From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Mar 2011 15:42:33 +0100
Subject: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
	OMAP data
In-Reply-To: <20110302113823.GB2728@pulham.picochip.com>
References: <AANLkTikvhj49DftS9c_NouASY9_MbYPCfmSUdJg6pf-5@mail.gmail.com>
	<4D6D9B10.9000606@codeaurora.org>
	<4D6D9D06.2020204@bluewatersys.com>
	<4D6D9FC7.1090206@codeaurora.org>
	<4D6DA290.2010607@bluewatersys.com>
	<4D6DAA24.3000204@codeaurora.org>
	<4D6DAE6E.4030701@bluewatersys.com>
	<4D6DB1B1.4060908@codeaurora.org> <4D6DFE67.3020801@stericsson.com>
	<AANLkTimJh_uGP6SYo=9ndz4xiUs1Tbg7z70ng0aFcWyG@mail.gmail.com>
	<20110302113823.GB2728@pulham.picochip.com>
Message-ID: <AANLkTimdAMLk4scWECNjUmtxKNzd5bBK8VNcLjs8JjBH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/3/2 Jamie Iles <jamie@jamieiles.com>:

>> > /sys/devices/system/soc/
>> > /sys/devices/system/soc/unique_id<- Unified way to export an ID for all machs
>>
>> Arbitrary number of bits? Some will have a 64-bit ID, some will have 32-bit
>> etc.
>>
>> Should we say it's a hex string of 64 bits?
>
> Could we provide hooks for the platform that takes the buffer and length
> and let the platform do the snprintf()? ?Our devices have a 128-bit
> serial number and I'm sure there must be others.

Isn't it better to just make it 64-bit so that apps can always parse it,
and then you can have your high-res numbers under mach?

If there is no solid ABI for this there is no point to make it
generic under /soc/unique_id at all.

/soc/name is another useful thing to have I think.

Apart from this we are now en route to the same color of
bikeshed discussion this patchset saw earlier, Maxime please
just implement something that works for you/us so others
can patch in whatever they need on top later.

Yours,
Linus Walleij
