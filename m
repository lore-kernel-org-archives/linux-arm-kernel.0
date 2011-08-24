From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 24 Aug 2011 15:46:13 +0300
Subject: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
In-Reply-To: <CAK=WgbZYuuKHUu6P+nfNzPgF4QmoL=T9+yquc=rMXRh4QE9grg@mail.gmail.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-2-git-send-email-ohad@wizery.com>
	<20110823140746.GP2079@amd.com>
	<CAK=WgbZYuuKHUu6P+nfNzPgF4QmoL=T9+yquc=rMXRh4QE9grg@mail.gmail.com>
Message-ID: <CAK=WgbZAMbPhDuXZ2NwTTSDv2doT6WBSzCCaD0F02mybNEZyeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 5:59 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Tue, Aug 23, 2011 at 5:07 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
>> Can this be easily converted to a spin_lock?
>
> Sure, thanks for reviewing.

Taking a second look, I don't think it's necessary - the mutex isn't
used to protect the page table. The page table is protected by a spin
lock, so map/unmap operations can be called from an atomic context.

The mutex is only part of the attach/deattach operations, which are
already used today in process context, so I guess it's safe.
