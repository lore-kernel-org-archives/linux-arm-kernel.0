From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Wed, 07 Oct 2009 16:10:32 +0400
Subject: [PATCH 2/9] collie: prepare for gpiolib use
In-Reply-To: <19148.32752.740077.475080@ipc1.ka-ro>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>	<1254778533-3529-2-git-send-email-thommycheck@gmx.de>	<1254778533-3529-3-git-send-email-thommycheck@gmx.de>	<20091007110805.GA7656@rainbow>	<20091007112552.GC6246@n2100.arm.linux.org.uk>
	<19148.32752.740077.475080@ipc1.ka-ro>
Message-ID: <4ACC8538.8050709@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Lothar Wa?mann wrote:

>>>>prefix gpio definitions for direct register access with '_' so we
>>>>can use the other names for gpio_request & co

>>>Familiar problem - numeric vs bit-shifted gpio defines.
>>>I'm facing it here too while converting h3[16]00 to gpiolib,
>>>and I'm thinking about dropping bit-shifted defines completely
>>>and using GPIO_GPIO(SOME_NUMERIC_GPIO) instead.

>>What we did with PXA was to decide not to use definitions for the built-in
>>GPIOs - what's the point of:

>>#define GPIO0	0
>>#define GPIO1	1
>>#define GPIO2	2
>>...

> A point could be that 'grep GPIO0 ...' would find any usage of that
> GPIO in the kernel source while 'grep 0 ...' would be quite
> pointless.

    That's why some people have GPIO(n) macro. :-)

#define GPIO(n)	(n)

> Lothar Wa?mann

WBR, Sergei
