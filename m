From: balbi@ti.com (Felipe Balbi)
Date: Tue, 9 Jul 2013 14:27:51 +0300
Subject: [PATCH v2] arm: dts: AM43x: Add usb_otg_hs node
In-Reply-To: <51DBF23F.20103@ti.com>
References: <1373361446-30050-1-git-send-email-george.cherian@ti.com>
 <20130709102022.GH5552@arwen.pp.htv.fi> <51DBF23F.20103@ti.com>
Message-ID: <20130709112751.GI5552@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 09, 2013 at 04:51:35PM +0530, George Cherian wrote:
> >>+				compatible = "snps,dwc3";
> >>+				reg = <0x48390000 0xcfff>;
> >weird size, shouldn't this be 0xd000 then the size would be exactly
> >52KiB
> 
> okay

btw, the reason here is that when you call devm_ioremap_resource(), that
will call resource_size() which does:

	size = res->end - res->start - 1;

so you need this extra 1 on the size when passing it via DT.

> >Another thing: am437x has 4 instances of this IP, why are you adding
> >only one ?
> 
> AM437x has got only 2 instances. I have verified only one on HAPS so
> adding only one.

weird, on my TRM I see for dwc3 but 2 PHYs.

> >And why aren't you pasing the PHY nodes here ? The device
> >won't work without its PHYs.
> 
> Yes true, again in HAPS I  didnt have any PHY configuration to be done.

alright, but we should still pass the PHY right ? once silicon comes,
we want this to work without any further changers.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/0b64e433/attachment.sig>
