From: balbi@ti.com (Felipe Balbi)
Date: Mon, 19 Jan 2015 15:41:13 -0600
Subject: [PATCH] ARM: omap2plus_defconfig: Enable OHCI & EHCI HCD support
In-Reply-To: <1421702475.6818.19.camel@collabora.co.uk>
References: <1421701046-17367-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <20150119210341.GR20386@saruman> <20150119210832.GS20386@saruman>
 <1421702475.6818.19.camel@collabora.co.uk>
Message-ID: <20150119214113.GU20386@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 19, 2015 at 10:21:15PM +0100, Sjoerd Simons wrote:
> On Mon, 2015-01-19 at 15:08 -0600, Felipe Balbi wrote:
> > On Mon, Jan 19, 2015 at 03:03:41PM -0600, Felipe Balbi wrote:
> > > On Mon, Jan 19, 2015 at 09:57:26PM +0100, Sjoerd Simons wrote:
> > > > Enable CONFIG_USB_EHCI_HCD and CONFIG_USB_OHCI_HCD to get USB supports
> > > > with omap2plus_defconfig.
> > > > 
> > > > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > > > ---
> > > >  arch/arm/configs/omap2plus_defconfig | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> > > > index c2c3a85..295af70 100644
> > > > --- a/arch/arm/configs/omap2plus_defconfig
> > > > +++ b/arch/arm/configs/omap2plus_defconfig
> > > > @@ -159,6 +159,8 @@ CONFIG_USB_NET_SMSC95XX=y
> > > >  CONFIG_USB_ALI_M5632=y
> > > >  CONFIG_USB_AN2720=y
> > > >  CONFIG_USB_EPSON2888=y
> > > > +CONFIG_USB_EHCI_HCD=y
> > > > +CONFIG_USB_OHCI_HCD=y
> > > 
> > > should be modules as they break PM.
> > 
> > oh, and when resending, please add linux-omap to Cc, that's listed in
> > MAINTAINERS.
> 
> Hrm,
> 
> Seems like MAINTAINERS is missing an entry to make get_maintainer.pl
> recognize linux-omap should be cc'd:
> 
> $ ./scripts/get_maintainer.pl -f arch/arm/configs/omap2plus_defconfig
> Russell King <linux@arm.linux.org.uk> (maintainer:ARM PORT)
> Tony Lindgren <tony@atomide.com>
> (commit_signer:23/24=96%,authored:10/24=42%,added_lines:74/107=69%,removed_lines:21/24=88%)
> Felipe Balbi <balbi@ti.com>
> (commit_signer:7/24=29%,authored:5/24=21%,added_lines:22/107=21%)
> Arnd Bergmann <arnd@arndb.de> (commit_signer:6/24=25%)
> Nishanth Menon <nm@ti.com> (commit_signer:2/24=8%)
> linux-arm-kernel at lists.infradead.org (moderated list:ARM PORT)
> linux-kernel at vger.kernel.org (open list)

I'll send a patch (unless Tony wants to do it), thanks for reporting.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/a7b6456d/attachment.sig>
