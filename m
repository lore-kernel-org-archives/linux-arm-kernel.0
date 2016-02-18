From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 18 Feb 2016 15:24:09 +0100
Subject: [PATCH] PCI: mvebu: Restrict build to 32-bit ARM
In-Reply-To: <5051836.EUN3ennYNm@wuerfel>
References: <1455802330-17565-1-git-send-email-thierry.reding@gmail.com>
 <5051836.EUN3ennYNm@wuerfel>
Message-ID: <20160218142409.GA4678@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 03:06:23PM +0100, Arnd Bergmann wrote:
> On Thursday 18 February 2016 14:32:10 Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > This driver uses PCI glue that is only available on 32-bit ARM. This
> > used to work fine as long as ARCH_MVEBU and ARCH_DOVE were exclusively
> > 32-bit, but that's changed now, with ARCH_MVEBU also being available
> > on 64-bit ARM.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> Looks fine as a temporary workaround, but I think what we really want to
> do here is to remove the dependency, as the new ARM64 platforms are going
> to need this driver anyway.

Agreed. I've been meaning to do just that for Tegra as well, but the
conversion is somewhat more involved and this is currently breaking the
linux-next builds, so a quick fix, even if temporary, is warranted in my
opinion.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160218/a03a27ec/attachment-0001.sig>
