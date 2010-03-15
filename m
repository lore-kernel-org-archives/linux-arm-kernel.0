From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 15 Mar 2010 23:19:19 +0100
Subject: [PATCH] ARM: SAMSUNG: Add suspend/resume support for S3C PWM
	driver
In-Reply-To: <201003152324.15260.anarsoul@gmail.com>
References: <1268663228-27515-1-git-send-email-anarsoul@gmail.com>
	<201003152217.02781.anarsoul@gmail.com>
	<4B9E9946.9030607@metafoo.de>
	<201003152324.15260.anarsoul@gmail.com>
Message-ID: <4B9EB267.3010300@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Vasily Khoruzhick wrote:
> ? ????????? ?? 15 ????? 2010 22:32:06 ????? Lars-Peter Clausen
> ???????:
>
>> Hi
>>
>> Because it would require to implement the same functionality over
>> and over again. Furthermore it would require each generic driver
>> using the pwm api to provide such callbacks. And you - as a user
>> of the api - will have to know about this oddity. In my opinion
>> it is a detail specific to the samsung platform and should be
>> hidden behind the common interface.
>>
>> - Lars
>
> So, you want to configure corresponding GPIO pin as output and set
> it to low in pwm_disable, re-configure it as PWM output in
> pwm_enable, and disable/enable PWM during suspend/resume cycle? If
> so - it's easy to implement, but I want to hear Ben's opinion.
>
> Regards Vasily
Hi

Yes. That's what I would prefer. The PWM is, if I'm not mistaken,
implicitly turned of during suspend anyway.
One problem that arises is that the PWM pins have different numbers on
different Samsung SoC types, which was iirc the reason why the driver
has been written without pin configuring support.
But if the mapping is needed anyway it might also be desirable to
configure the corresponding pin as PWM pin in the drivers probe
function. Cause this currently has to be done separately as well.

But yes, lets wait for Ben's opinion.

- - Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkuesmYACgkQBX4mSR26RiMd5ACffExKN2W9L6/MzLi7b4wG/xa3
fHUAn02pW+1m1KdDfyyrUtW1GW8Az+9c
=IrGE
-----END PGP SIGNATURE-----
