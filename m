From: padma.kvr@gmail.com (Padma Venkat)
Date: Sat, 27 Jul 2013 06:46:40 +0530
Subject: [PATCH V2 7/8] ARM: dts: wm8994: Add wm8994 support on smdk5420
In-Reply-To: <20130726151902.GL9858@sirena.org.uk>
References: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
 <1374845812-7803-8-git-send-email-padma.v@samsung.com>
 <20130726151902.GL9858@sirena.org.uk>
Message-ID: <CAAgF-Be8SNxTZv1yFCwH6yJ-O_3R4reh=3y+pSCLJYW7S9TkUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Jul 26, 2013 at 8:49 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 26, 2013 at 07:06:51PM +0530, Padmavathi Venna wrote:
>> This patch adds wm8994 codec node on i2c bus1 and the required
>> regulator supplies and properties on smdk5420 board.
>
> This isn't a device tree patch for WM8994, it's a patch for the
> SMDK5420.

Yes. I will correct the subject.

>
>> +     vdd: fixed-regulator at 0 {
>> +             compatible = "regulator-fixed";
>> +             regulator-name = "vdd-supply";
>
> These names look wrong - they should reflect the names in the schematic
> as they're for human comprehensibility.  This may just be a case of
> dropping the -supply.

OK.

>
>> +             wm8994: wm8994 at 1a {
>> +                     compatible = "wlf,wm8994";
>> +                     reg = <0x1a>;
>> +
>> +                     gpio-controller;
>> +                     #gpio-cells = <2>;
>> +
>> +                     AVDD2-supply = <&vdd>;
>> +                     CPVDD-supply = <&vdd>;
>> +                     DBVDD-supply = <&dbvdd>;
>> +                     SPKVDD1-supply = <&spkvdd>;
>> +                     SPKVDD2-supply = <&spkvdd>;
>> +             };
>
> It would be helpful to also add a clock binding (I posted a binding
> documentation update the other day, it's in my tree now) but it's not
> essential and I suspect it needs some work on the clock driver side
> still.

OK. I will check this.

Thanks
Padma
