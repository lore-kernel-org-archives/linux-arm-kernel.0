From: lacombar@gmail.com (Arnaud Lacombe)
Date: Mon, 1 Aug 2011 13:20:26 -0400
Subject: [PATCH] Remove remaining references of CONFIG_GENERIC_TIME
In-Reply-To: <alpine.LFD.2.00.1108011737030.18706@xanadu.home>
References: <1312042478-26012-1-git-send-email-zdevai@gmail.com>
	<20110801083614.GC15578@n2100.arm.linux.org.uk>
	<CAMuHMdUpTDSRP_JmWqcCBtYwzna0hwmaBshpiF8kgvqoNcqYZA@mail.gmail.com>
	<20110801101410.GE15578@n2100.arm.linux.org.uk>
	<CAMuHMdUiLjMVwOqKPF6tHLpPxROrx=rRf3ednfTLrwGuZ2VF7A@mail.gmail.com>
	<CACqU3MVUxTYmD+4VGBAeN8PTs83fR0xQQrQS5h4QGMZXgMxEvA@mail.gmail.com>
	<CAGZ=bqL=VAx5jnSBkE2q5KJSY_+An-VRTRAzJmJ3waQUvrRFFg@mail.gmail.com>
	<CACqU3MUoxSNmcYsSF4zOTgADdedb7TcciPuBPMviG02M5oUPDQ@mail.gmail.com>
	<alpine.LFD.2.00.1108011737030.18706@xanadu.home>
Message-ID: <CACqU3MU_oq+RYydenKG_8U08rdJ-N+2hftH+2xEPZU0uVP6i5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 1, 2011 at 12:40 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Mon, 1 Aug 2011, Arnaud Lacombe wrote:
>
>> Moreover, this approach is deemed to fail. The current symbol
>> namespace is tied to an arch, so whenever you do:
>>
>> arch/arm/Kconfig:
>> config FOO
>> ? ? bool
>>
>> config BAZ
>> ? ? bool
>>
>> drivers/cpufreq/Kconfig
>> config BAR
>> ? ? depends on ARM && FOO
>> ? ? select BAZ
>>
>> You will end up triggering the warning for every ARCH != ARM...
>
> You can keep a state for those symbols with regard to their level of
> reference. ?Surely if ARM isn't true, BAZ is not "actively" referenced
> in the end.
>
he :) we enter in compilers optimizations. As much as I agree with
you, that might not be trivial to implement given the internal,
ad-hoc, structure of kconfig. All of that would be useless if we had a
single global namespace.

 - Arnaud
