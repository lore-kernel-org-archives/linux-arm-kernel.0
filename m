From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 14 Dec 2013 21:29:07 +0800
Subject: [PATCH V1 05/11] ARM: dts: imx6qdl-sabrelite: specify pad settings
In-Reply-To: <201312132250.29518.marex@denx.de>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
 <201312131248.32208.marex@denx.de>
 <52AB5511.7040209@boundarydevices.com>
 <201312132250.29518.marex@denx.de>
Message-ID: <20131214132905.GB16177@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 10:50:29PM +0100, Marek Vasut wrote:
> On Friday, December 13, 2013 at 07:42:25 PM, Troy Kisky wrote:
> > On 12/13/2013 4:48 AM, Marek Vasut wrote:
> > > On Friday, December 13, 2013 at 02:49:09 AM, Troy Kisky wrote:
> > >> Don't use 0x80000000 to get default pad settings.
> > > 
> > > What is the rationale behind this change please? Can you explain more in
> > > detail?
> > 
> > No real need, but I thought relying on what the boot loader did or did
> > not do
> > was discouraged?
> 
> Full ACK on this, we do not rely on bootloader configuration (though these two 
> should be in-line).
> 
> > What is the value in not explicitly setting the pad registers?
> 
> My question was in the direction of "why do you need to change the pin 
> configuration values from the current ones?". This is what I want to understand.
> 
> > Btw, I need to rebase series on your patch anyway so omitting this patch
> > would be easy.
> 
> I am not saying to omit it, please do not misunderstand me. I am just wondering 
> why the change from 0x80000000 to 0x1b0b0 .

Per Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt,

 Bits used for CONFIG:
 NO_PAD_CTL(1 << 31): indicate this pin does not need config.

0x80000000 tells pinctrl driver to not touch pad config register@all.
In that case, the configuration of the pad will be what boot loader
configures or just the reset value.

Explicitly putting a proper pad config value instead of 0x80000000
should be something we encourage.

Shawn
