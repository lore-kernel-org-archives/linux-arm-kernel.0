From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 28 Mar 2011 10:22:01 +0200
Subject: [PATCH RFC] ARM: PXA27x: CPUFREQ: Don't use fastbus mode
In-Reply-To: <201103272013.19981.anarsoul@gmail.com>
References: <1301169103-23968-1-git-send-email-anarsoul@gmail.com>
	<1301240089.10831.2.camel@konomi> <87r59sbixx.fsf@free.fr>
	<201103272013.19981.anarsoul@gmail.com>
Message-ID: <4D904529.9090404@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/11 19:13, Vasily Khoruzhick wrote:

> On Sunday 27 March 2011 19:56:58 Robert Jarzmik wrote:
>
>> These 2 work well on the mioa701 platform, under the constraint that the
>> minimal frequency is set to 208 instead of 104.
>>
>> I would think as Marek that it's a under-voltage issue, unless it's the
>> 104Mhz transition issue which lasts for as long as I own my platform (and
>> which might be mioa701 specific AFAIK).
> I tried to disable regulator at all (so, regulator is left in default state), 

What is the default state on Z2? Can you measure it?
The most important are VCC_CORE and VCC_MEM and usually there should be
some "good" capacitors on those, so it should be relatively easy to measure.

> stock bootloader configures CPU to 208mhz(normal)/312mhz(fast) and enables 
> fast mode, but leaves fastbus disabled. So I tried fixed 208mhz and 312mhz 
> with fastbus bit set - it hangs in random places, even without cpu freq 
> transitions... So maybe it's some hw misdesign,

Yep, it looks like it is... PXA27x local bus was always hard to please...

>  but once again - it works 
> pretty stable @104-416mhz with fastbus disabled.


-- 
Regards,
Igor.
