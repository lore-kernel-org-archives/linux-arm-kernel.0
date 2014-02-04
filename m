From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Feb 2014 20:21:38 +0100
Subject: [PATCH] arm64: Add architecture support for PCI
In-Reply-To: <20140204191055.GC25695@obsidianresearch.com>
References: <1391453028-23191-1-git-send-email-Liviu.Dudau@arm.com>
 <8676627.b6SYsazoah@wuerfel> <20140204191055.GC25695@obsidianresearch.com>
Message-ID: <4118142.2mQ5BlBdTZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 February 2014 12:10:55 Jason Gunthorpe wrote:
> 
> For instance to support peer-to-peer IO you need to have a consisent,
> non-overlapping set of bus/device/function/tag to uniquely route TLPs
> within the chip. Cross domain TLP routing in HW is non-trivial.

Yes, that is a good reason.

> IOMMUs (and SR-IOv) rely on the BDF to identify the originating device
> for each TLP. Multiple domains means a much more complex IOMMU
> environment.

I fear we already have to support complex IOMMU setups on ARM,
whether there are multiple PCI domains or not. But it would be
nice in theory not to require it.

> Failure to integrate on-chip devices into the PCI world also means
> thing like SR-IOv won't work sanely with on-chip devices.

I'd consider this a feature ;)

But you are probably right: people will do SR-IOV whether we like
it or not, and they will try to do it on non-PCI devices too,
and great suffering will be involved.

	Arnd
