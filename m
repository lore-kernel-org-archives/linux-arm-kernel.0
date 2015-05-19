From: bp@alien8.de (Borislav Petkov)
Date: Tue, 19 May 2015 22:33:36 +0200
Subject: [PATCH v10 1/5] arm64: Enable EDAC on ARM64
In-Reply-To: <CAPw-ZT=mTpt_vz+e=rM5ywK8feNKkJQrpEWg=noRCziJ0840TQ@mail.gmail.com>
References: <1431991481-25684-1-git-send-email-lho@apm.com>
 <1431991481-25684-2-git-send-email-lho@apm.com>
 <20150519170308.GL4641@pd.tnic>
 <CAPw-ZT=mTpt_vz+e=rM5ywK8feNKkJQrpEWg=noRCziJ0840TQ@mail.gmail.com>
Message-ID: <20150519203336.GP4641@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 12:57:32PM -0700, Loc Ho wrote:
> This was discussed here
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/326986.html.
> Without this, it will have compiler error as this function is called
> by.function edac_mc_scrub_block in file drivers/edac/edac_mc.c.

Argh, that's just silly. We should have a __weak atomic_scrub() in the
edac core which arches can override but not have to supply a dummy just
because...

I'll try to hack up something later.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
