From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Mon, 13 Apr 2015 22:01:00 +0300
Subject: [PATCH] ARM: dts: sun7i: Add Goodix GT911 nodes for Wexler TAB7200
In-Reply-To: <20150413160951.GJ29832@lukather>
References: <1427789897-4085-1-git-send-email-mamlinav@gmail.com>
 <20150331144338.GG23664@lukather>
 <20150331221420.3b65d2540c7dbe1d12611e12@gmail.com>
 <20150402092259.GK23664@lukather>
 <20150411191816.cdc5ec802b01028eb2913906@gmail.com>
 <20150413160951.GJ29832@lukather>
Message-ID: <20150413220100.8666a3d121fce581ba836fe6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Apr 2015 18:09:51 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Sat, Apr 11, 2015 at 07:18:16PM +0300, Aleksei Mamlin wrote:
> > On Thu, 2 Apr 2015 11:22:59 +0200
> > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> > 
> > > On Tue, Mar 31, 2015 at 10:14:20PM +0300, Aleksei Mamlin wrote:
> > > > On Tue, 31 Mar 2015 07:43:38 -0700
> > > > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> > > > 
> > > > > Hi,
> > > > > 
> > > > > On Tue, Mar 31, 2015 at 11:18:17AM +0300, Aleksei Mamlin wrote:
> > > > > > This patch adds nodes for the Goodix GT911 touchscreen controller found
> > > > > > on the Wexler TAB7200 tablet. Controller uses one of following I2C
> > > > > > addresses: 0x5d or 0x14, so just add two nodes.
> > > > > 
> > > > > In which case are these different addresses encountered? Different
> > > > > revisions of the same board?
> > > >
> > > > According to the datasheet it is a feature of the controller. 
> > > > The address(0x5d or 0x14) can be configured using a reset sequence,
> > > > which has not yet been implemented in the driver.
> > > 
> > > Which address is set up by the bootloader then?
> >
> > I assume that bootloader(u-boot) didn't sets up any address, but touchscreen
> > controller usually uses 0x5d. Sometimes, after hard reset, it uses 0x14.
> > For this we need nodes on both adresses.
> 
> I'm confused, who changes that address then?
> 
> The controller itself?
> 
If I understood correctly, when device starts it sets reset pin (PB13) to
high level and int pin(PH21) to low level. After this int pin sets up as
external interrupt. This sequence triggers controller to use 0x5d address.

After hard reset both pins may be hight level and it triggers controller
to use 0x14 address.

Please see datasheets at pages 8-10.

https://drive.google.com/file/d/0BxCVOQS3ZymGdEE0cHI3bnp5WVE
https://drive.google.com/file/d/0BxCVOQS3ZymGbDAzVnZwZ2lOZ1E
>
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com


-- 
Thanks and regards,
Aleksei Mamlin
