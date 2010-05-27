From: rob@emanuele.us (Robert Emanuele)
Date: Wed, 26 May 2010 18:33:47 -0700
Subject: Controlling Driver Load Order
In-Reply-To: <20100526235246.GA31068@pengutronix.de>
References: <AANLkTikzDvWakd7JW3DzTHinjS3dAlqzPx6K8V2qMDG7@mail.gmail.com>
	<AANLkTinkY8JYh44UOEPflBUDyQ2wat_AKShRjA3HPxrf@mail.gmail.com>
	<20100526235246.GA31068@pengutronix.de>
Message-ID: <AANLkTinhbSuKl3ajWEonsgsa_BVbUDffK7tNAXINUGZN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maybe I'm not describing this correctly...
In my platform init_machine I had something like this:
{
at91_add_device_i2c(1, my_i2c_devices, ARRAY_SIZE(my_i2c_devices));

add_my_display


On Wed, May 26, 2010 at 4:52 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Wed, May 26, 2010 at 11:04:01PM +0200, Linus Walleij wrote:
>> 2010/5/26 Robert Emanuele <rob@emanuele.us>:
>>
>> > On my at91sam9g45 platform I need my i2c drivers to load before the
>> > framebuffer driver. ?The i2c drivers control a power management IC
>> > which is needed to enable the graphics controller.
>> >
>> > Is there a way to set up that order?
>>
>> The usual trick (which you can find in a lot of other I2C busses) is to use
>> a core_initcall() instead of module_init().
>
> Correct, but it's subsys_initcall().
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Wolfram Sang ? ? ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkv9tE4ACgkQD27XaX1/VRsuwgCgtuBO/G43yUxbTED+MdBf6tUv
> 9hYAn0WL0L475IYsXqiOlUMzGmdrAcr7
> =KcVU
> -----END PGP SIGNATURE-----
>
>
