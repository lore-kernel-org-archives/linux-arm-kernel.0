From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 24 Aug 2011 17:46:37 +0300
Subject: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
In-Reply-To: <20110824131527.GI2079@amd.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-2-git-send-email-ohad@wizery.com>
	<20110823140746.GP2079@amd.com>
	<CAK=WgbZYuuKHUu6P+nfNzPgF4QmoL=T9+yquc=rMXRh4QE9grg@mail.gmail.com>
	<CAK=WgbZAMbPhDuXZ2NwTTSDv2doT6WBSzCCaD0F02mybNEZyeA@mail.gmail.com>
	<20110824131527.GI2079@amd.com>
Message-ID: <CAK=WgbYtTvCi4yLBJphvni4XiZLwm_Rj9aZFXaTwg44J1BDGsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 4:15 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> Yes, it should be safe in your context. But the iommu-api is generic and
> I would prefer that all functions it provides can be called from any
> context.

Not a problem.

I thought you only cared about map/unmap, but if you prefer
attach/deattach to be atomic too, I'll migrate the driver to use a
spin lock.

> Or is the time required for attaching/detaching too long so that it
> makes sense to put secondary threads to sleep?

It doesn't look like it. I think a mutex was originally chosen at that
point because those functions were used in a process context.

Thanks,
Ohad.
