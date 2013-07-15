From: balbi@ti.com (Felipe Balbi)
Date: Mon, 15 Jul 2013 18:46:03 +0300
Subject: [PATCH 2/4] arm: omap5: hwmod: add missing ocp2scp hwmod data
In-Reply-To: <51E418A4.9000109@ti.com>
References: <1373902423-28654-1-git-send-email-balbi@ti.com>
 <1373902423-28654-3-git-send-email-balbi@ti.com>
 <51E418A4.9000109@ti.com>
Message-ID: <20130715154603.GC32035@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 09:13:32PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 15 July 2013 09:03 PM, Felipe Balbi wrote:
> > From: Benoit Cousson <benoit.cousson@linaro.org>
> > 
> > without that hwmod data, USB3 will not in OMAP5 boards.
> > 
> > While at that, also fix DTS data to pass reg property,
> > otherwise driver won't probe.
> > 
> > Signed-off-by: Benoit Cousson <benoit.cousson@linaro.org>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  arch/arm/boot/dts/omap5.dtsi               |  3 +-
> >  arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 45 ++++++++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> > index 5c99f19..4e41409 100644
> > --- a/arch/arm/boot/dts/omap5.dtsi
> > +++ b/arch/arm/boot/dts/omap5.dtsi
> > @@ -652,10 +652,11 @@
> >  			};
> >  		};
> >  
> > -		ocp2scp {
> > +		ocp2scp at 4a080000 {
> 
> While at that, can we also name it ocp2scp1 since we have 3 instances of
> ocp2scp and it'll conflict when we want to add it for SATA and PCIE.

Tony/Benoit, you want that in same patch or as a separate patch
altogether ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130715/a33075f5/attachment.sig>
