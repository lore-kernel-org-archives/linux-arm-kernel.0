From: tj@kernel.org (Tejun Heo)
Date: Sat, 29 Jun 2013 08:29:59 -0700
Subject: [PATCH] WIP: HACK: LPAE, BOOTMEM and NO_BOOTMEM
In-Reply-To: <1372467663-31425-1-git-send-email-santosh.shilimkar@ti.com>
References: <1372467663-31425-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130629152959.GB31339@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I haven't looked at bootmem for a while so could be a bit out of touch
but a couple questions.

On Fri, Jun 28, 2013 at 09:01:03PM -0400, Santosh Shilimkar wrote:
> - Started replacing bootmem_* usage with dirty hacked memblock based API.
> This can be letter wrapped with only needed parameter export.

You can't use memblock directly?

> - Couple of ARM related patch-ups were fine but soon realized that we need
> to patch generic kernel multiple places .. So decided to stop and check again
> These changes are becoming too much...

I suppose LPAE on arm is analogous to PAE on x86, IOW, high memory?
This does affect memory initilization as you need to register memory
areas which aren't addressable directly; however, why does it affect
generic code which is just allocating memory?  Note that x86 already
does highmem and the existing code works fine.  Once all bootmem users
are gone, we can remove the bootmem wrappers but I don't what the
point is with introducing yet another wrapper.

Thanks.

-- 
tejun
