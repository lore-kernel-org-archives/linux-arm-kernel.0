From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 12 Sep 2016 08:24:31 -0400
Subject: [PATCH v2 4/4] ARM: dts: imx28: Fix build warnings with W=1
In-Reply-To: <20160912120908.GA7273@tiger>
References: <1473103670-15922-1-git-send-email-festevam@gmail.com>
 <1473103670-15922-4-git-send-email-festevam@gmail.com>
 <20160908140338.GD16911@tiger>
 <20160909091441.01b152ca@ipc1.ka-ro> <20160912120908.GA7273@tiger>
Message-ID: <CABxcv=koZTjDuAoHBDw-y9ErGs6EyKNWc2iVRqiW3R0eUscvPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Mon, Sep 12, 2016 at 8:09 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Fri, Sep 09, 2016 at 09:14:41AM +0200, Lothar Wa?mann wrote:
>> Hi,
>>
>> On Thu, 8 Sep 2016 22:03:38 +0800 Shawn Guo wrote:
>> > On Mon, Sep 05, 2016 at 04:27:50PM -0300, Fabio Estevam wrote:
>> > > diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
>> > > index 0ebbc83..b4d4dbb 100644
>> > > --- a/arch/arm/boot/dts/imx28-tx28.dts
>> > > +++ b/arch/arm/boot/dts/imx28-tx28.dts
>> > > @@ -35,7 +35,8 @@
>> > >           usbotg = &usb0;
>> > >   };
>> > >
>> > > - memory {
>> > > + memory at 0 {
>> > > +         device_type = "memory";
>> > >           reg = <0 0>; /* will be filled in by U-Boot */
>> >
>> > I'm curious to know if the unit-address will be fixed up or not when
>> > 'reg' property gets updated by U-Boot.
>> >
>> No. U-Boot does not change the unit name, when updating in the reg
>> property. But that does not do any harm (for now), thus the change is
>> OK.
>
> This is confusing when people is looking at nodes in /proc/device-tree.
> Why cannot we give it a reasonable default configuration instead of
> <0 0>?
>

Another option is to not have a memory node if the start address is
not known at build time, since U-boot creates a memory node if is not
found in the FDT.

> Shawn
>

Best regards,
Javier
