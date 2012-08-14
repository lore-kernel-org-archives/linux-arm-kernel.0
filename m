From: balbi@ti.com (Felipe Balbi)
Date: Tue, 14 Aug 2012 12:59:26 +0300
Subject: [PATCHv2 2/4] arm/dts: omap5-evm: Add tmp102 sensor support
In-Reply-To: <502A20DD.5030707@ti.com>
References: <1344852313-30484-1-git-send-email-sourav.poddar@ti.com>
 <1344852313-30484-3-git-send-email-sourav.poddar@ti.com>
 <502A20DD.5030707@ti.com>
Message-ID: <20120814095923.GB11416@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 11:56:45AM +0200, Benoit Cousson wrote:
> On 08/13/2012 12:05 PM, Sourav Poddar wrote:
> > Add tmp102 temperature sensor data in omap5 evm dts file.
> > 
> > Tested on omap5430 evm with 3.5 custom kernel.
> > 
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Acked-by: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> > ---
> >  arch/arm/boot/dts/omap5-evm.dts |    9 +++++++++
> >  1 files changed, 9 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/omap5-evm.dts b/arch/arm/boot/dts/omap5-evm.dts
> > index 200c39a..45a8aeb 100644
> > --- a/arch/arm/boot/dts/omap5-evm.dts
> > +++ b/arch/arm/boot/dts/omap5-evm.dts
> > @@ -18,3 +18,12 @@
> >  		reg = <0x80000000 0x40000000>; /* 1 GB */
> >  	};
> >  };
> > +
> > +&i2c4 {
> > +	clock-frequency = <400000>;
> 
> Have you checked if we cannot run at faster speed? Reducing the speed
> will impact every devices on the bus.
> It might be needed, I just wanted to be sure.
> 
> You should maybe just add a small comment to explain what the device is
> doing with potentially a link to the HW spec if available.
> 
> The same comments are applicable to the bmp085 patch.

that sort of information should be placed on
Documentation/devicetree/bindings/*/$device.txt, right ? Why should we
replicate it on all dts files ? Besides, there are only two such entries
on all ARM DTS files. Do we really want to make dts files bigger with
links to documentation which can even be moved at any time to other
location by the manufacturer's choice ? Will anyone actually keep track
of such links to make sure they aren't broken ? And even if someone does
track those links, do we really want to keep sending such patches for
the dts files ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120814/705c3c66/attachment-0001.sig>
