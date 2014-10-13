From: stefan@agner.ch (Stefan Agner)
Date: Mon, 13 Oct 2014 12:03:12 +0200
Subject: [RFC 3/7] ARM: vf610m4: add new machine and SoC for Vybrid on
 Cortex-M4
In-Reply-To: <2790232.XFn8jX0Lfm@wuerfel>
References: <cover.1413136383.git.stefan@agner.ch>
 <d1b3670556c7c7a11092834abf52eedb22c332b7.1413136383.git.stefan@agner.ch>
 <2790232.XFn8jX0Lfm@wuerfel>
Message-ID: <776a06abd938d507d7798670e6ad27d1@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-10-12 20:51, schrieb Arnd Bergmann:
> On Sunday 12 October 2014 20:13:57 Stefan Agner wrote:
>> This patch adds a new machine ARCH_MXCM4 which requires !MMU and
>> !MULTIARCH and is meant as machine for the hetregenous multi-core
>> Vybrid/i.MX SoC's to run Linux on the Cortex-M4.
>>
>> The first SoC supported is Vybrid on Cortex-M4 (SOC_VF610M4).
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Not sure whether we really need a new MACH, but since MACH_MXC needs
>> MULTIARCH, which in turn conflicts with !MMU, I guess there is no
>> easier way to do it... And then, this also needs a new SOC.
> 
> I've carried an experimental patch to enable !MMU in combination with
> MULTIPLATFORM for a while, it's probably time to do this for real now,
> especially since we now have two !MMU platforms that can be built
> together. Independent of the question of whether such a combined kernel
> could run on real hardware or anybody would want to run such a kernel
> if it were possible, I think it's very useful to be able to build
> allmodconfig with MMU disabled and get all drivers for the available
> platforms for build testing.

Are these patches online somewhere?

That sounds interesting. I guess I can get rid of ARCH_MXCM4 then.
Still, SOC_VF610M4 will be needed. We just need to make ARCH_MXC also
available on !MMU and use if to distinguish !MMU/MMU SoC's.

--
Stefan
