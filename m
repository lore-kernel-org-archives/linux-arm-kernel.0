From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 18 Apr 2017 09:34:18 +0200
Subject: [PATCH 4/7] arm64: marvell: dts: add crypto engine description
 for 7k/8k
In-Reply-To: <20170412105608.41501b63@free-electrons.com>
References: <20170329124432.27457-1-antoine.tenart@free-electrons.com>
 <20170329124432.27457-5-antoine.tenart@free-electrons.com>
 <20170412105608.41501b63@free-electrons.com>
Message-ID: <20170418073418.tpgg7i27uigatddu@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, Apr 12, 2017 at 10:56:08AM +0200, Thomas Petazzoni wrote:
> On Wed, 29 Mar 2017 14:44:29 +0200, Antoine Tenart wrote:
> 
> > +			cpm_crypto: crypto at 800000 {
> > +				compatible = "inside-secure,safexcel-eip197";
> > +				reg = <0x800000 0x200000>;
> > +				interrupts = <GIC_SPI 34 (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_LEVEL_HIGH)>,
> 
> Now that I look into this, does it makes sense for an interrupt to be
> both an edge interrupt and a level interrupt at the same time? This
> looks odd.

I agree this looks odd. I took it from Russel's ICU mapping:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/489040.html

Also note the driver does not use it (yet?).

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170418/b8e12a4e/attachment.sig>
