From: mirza.krak@gmail.com (Mirza Krak)
Date: Mon, 25 Jul 2016 21:59:34 +0200
Subject: [RFC 3/6] dt/bindings: Add bindings for Tegra20/30 NOR bus driver
In-Reply-To: <20160725141544.GN21170@ulmo.ba.sec>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-4-git-send-email-mirza.krak@gmail.com>
 <20160725113034.GD21170@ulmo.ba.sec>
 <CALw8SCWEFVu__8Gyr5q995h+=oMQEz1VUNB=Ne7MRb0O-tZXqg@mail.gmail.com>
 <20160725141544.GN21170@ulmo.ba.sec>
Message-ID: <CALw8SCVmVL82kZapEJA97XqQv6XZnR_S6ddsW1Gwk61v4Px9AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-07-25 16:15 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> On Mon, Jul 25, 2016 at 03:16:28PM +0200, Mirza Krak wrote:
>> 2016-07-25 13:30 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
>> >
>> > I would've expected this to require some sort of infrastructure to allow
>> > devices connected to the GMI controller to acquire the bus via some API
>> > to select their chip.
>>
>> Yes, ultimately you would need some sort of infrastructure to allow
>> devices to acquire the GMI bus if you want to solve this in software.
>> But at the moment I do not see such an infrastructure in place, and is
>> it feasible to add one specifically for the GMI controller? If one
>> such infrastructure was in place we would need to modify all the
>> drivers that want to use to include Tegra specific infrastructure to
>> access the GMI bus?
>>
>> Since my knowledge is limited it hard for me to comment on this, maybe
>> there is a simple way of doing this?
>
> I don't think there's a simple way to do this. In order to properly
> implement it we'd need to implement a generic infrastructure for chip
> selects so that drivers such as the one for your CAN controller can be
> written without tying them specifically to the Tegra GMI controller.
>
> From what you and Jon were saying it sounds like the drivers are
> completely agnostic of any chip-select, so conversion won't be easy.
> But technically if these chips take a chip-select as input then it's
> always possible to hook them up to a controller that doesn't do this
> automatic translation of address to chip-select, so eventually some
> setup is bound to come along where they'd need explicit chip-select
> handling as well.
>
> I don't think it's fair to require you to implement this infrastructure
> if you don't actually need it. At the same time I want to be cautious
> and make sure we keep the driver and binding flexible enough to allow
> us to implement explicit chip-selects should we later need them.
>
> Thierry

One thing that should be noted, and that is the GMI controller also
supports a DMA master mode (feature for the future?).

I do not really know how this effects the binding we are discussing
but wanted to put it out there.

Best Regards,
Mirza
