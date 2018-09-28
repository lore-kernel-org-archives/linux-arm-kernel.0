From: 93sam@debian.org (Steve McIntyre)
Date: Fri, 28 Sep 2018 14:18:11 +0100
Subject: [RESEND PATCH 0/2] Don't use SIGMINSTKSZ when enforcing
 alternative signal stack size for compat tasks
In-Reply-To: <20180926103627.b6kxzdmqqsj3545h@arm.com>
References: <1536158083-30166-1-git-send-email-will.deacon@arm.com>
 <20180926103627.b6kxzdmqqsj3545h@arm.com>
Message-ID: <20180928131805.aunjzciyvaad7z5a@tack.einval.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Re-sending without the corporate footer garbage... ]

On Wed, Sep 05, 2018 at 03:34:41PM +0100, Will Deacon wrote:
>Hi all,
>
>This is a resend of:
>
>  http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593559.html
>
>now based on 4.19-rc2.
>
>The Debian folks have observed a failure in the 32-bit arm glibc testsuite
>when running under a 64-bit kernel. They tracked this down to sigaltstack(2)
>enforcing the alternative signal stack to be at least SIGMINSTKSZ bytes,
>which is higher for native arm64 tasks than compat 32-bit tasks.
>
>These patches resolve the issue by allowing an architecture to define
>COMPAT_SIGMINSTKSZ for compat tasks, which is then used by the sigaltstack
>checking code.
>
>Feedback welcome,

Apologies for the delayed response here - conference travel etc . got
in the way... I've just tested and I can confirm that this patchset
fixes our reported bug (as in https://bugs.debian.org/904385). Thanks
Will!

Tested-by: Steve McIntyre <93sam@debian.org>

-- 
Steve McIntyre  <93sam@debian.org>
