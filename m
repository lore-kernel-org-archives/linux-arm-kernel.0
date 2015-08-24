From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 24 Aug 2015 20:01:29 +0200
Subject: [PATCH v2 1/3] ARM: dts: rockchip: add veyron-jaq board
In-Reply-To: <7504130.baa3QaVrQb@phil>
References: <1440022721-73712-1-git-send-email-briannorris@chromium.org>
 <CABxcv=nQAfCzj_bQ9N-XYEPCNuihyrkUOz7=ogetKzye4KKNng@mail.gmail.com>
 <20150824175315.GA81574@google.com> <7504130.baa3QaVrQb@phil>
Message-ID: <CABxcv=nXwL6LV0vnjffA0JV4NB-_mCufe3-0c7fsRKW3DE+-_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Heiko,

On Mon, Aug 24, 2015 at 7:58 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Montag, 24. August 2015, 10:53:15 schrieb Brian Norris:
>> On Thu, Aug 20, 2015 at 01:29:40AM +0200, Javier Martinez Canillas wrote:
>> > Hello Brian,
>> >
>> > [...]
>> >
>> > > +
>> > > +&rk808 {
>> > > +       pinctrl-names = "default";
>> > > +       pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
>> > > +       dvs-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>,
>> > > +                   <&gpio7 15 GPIO_ACTIVE_HIGH>;
>> >
>> > I see the dvs-gpios DT property is documented in the downstream
>> > ChromiumOS 3.18 tree [0] but I don't see it neither mentioned in
>> > Documentation/devicetree/bindings/mfd/rk808.txt in mainline nor code
>> > that parses it in the drivers/regulator/rk808-regulator.c driver.
>>
>> Good catch.
>>
>> > So I think this should be removed and also the dvs_{1,2} pinctrl
>> > lines.
>>
>> OK, will do. I see that jerry, minnie, and speedy also have the pinctrl
>> lines. Should they be killed as well?
>
> Personally I think the pinctrl settings can stay. Their configuration is part
> of the hardware and not subject to the binding of the device using them.
>
> And of course, the change to support them is already pending, with the binding
> itself already in the mfd tree.
>

I missed that the change to add support for this is already in the mfd tree.

>
> So it doesn't matter to much if they're in there already or not, as we'll
> hopefully soon make use of them anyway.
>

Agreed.

Best regards,
Javier
