From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 1 Oct 2018 11:43:31 +0100
Subject: [RESEND PATCH 0/2] Don't use SIGMINSTKSZ when enforcing
 alternative signal stack size for compat tasks
In-Reply-To: <20180928131805.aunjzciyvaad7z5a@tack.einval.com>
References: <1536158083-30166-1-git-send-email-will.deacon@arm.com>
 <20180926103627.b6kxzdmqqsj3545h@arm.com>
 <20180928131805.aunjzciyvaad7z5a@tack.einval.com>
Message-ID: <20181001104330.GC131162@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 02:18:11PM +0100, Steve McIntyre wrote:
> On Wed, Sep 05, 2018 at 03:34:41PM +0100, Will Deacon wrote:
> >Hi all,
> >
> >This is a resend of:
> >
> >  http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593559.html
> >
> >now based on 4.19-rc2.
> >
> >The Debian folks have observed a failure in the 32-bit arm glibc testsuite
> >when running under a 64-bit kernel. They tracked this down to sigaltstack(2)
> >enforcing the alternative signal stack to be at least SIGMINSTKSZ bytes,
> >which is higher for native arm64 tasks than compat 32-bit tasks.
> >
> >These patches resolve the issue by allowing an architecture to define
> >COMPAT_SIGMINSTKSZ for compat tasks, which is then used by the sigaltstack
> >checking code.
> >
> >Feedback welcome,
> 
> Apologies for the delayed response here - conference travel etc . got
> in the way... I've just tested and I can confirm that this patchset
> fixes our reported bug (as in https://bugs.debian.org/904385). Thanks
> Will!
> 
> Tested-by: Steve McIntyre <93sam@debian.org>

Thanks for confirming Steve.

As there is no functional change for other architectures, I'll queue
both patches through the arm64 tree. If anyone objects, please let me
know before the merging window.

-- 
Catalin
