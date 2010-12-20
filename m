From: alchark@gmail.com (Alexey Charkov)
Date: Mon, 20 Dec 2010 22:26:22 +0300
Subject: [PATCH 1/6 v8] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <20101220191549.GH28157@n2100.arm.linux.org.uk>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<20101107165745.GB1759@n2100.arm.linux.org.uk>
	<AANLkTimFJ=Brx4pDiUqZOKDfABaDg0s_yFC7EkZGi7D8@mail.gmail.com>
	<20101107171726.GF1759@n2100.arm.linux.org.uk>
	<20101108171930.GA1471@alchark-u3s.lan>
	<20101111212322.GA15533@alchark-u3s.lan>
	<20101111234957.GA28735@n2100.arm.linux.org.uk>
	<20101219174017.GA31832@alchark-u3s>
	<20101220191549.GH28157@n2100.arm.linux.org.uk>
Message-ID: <AANLkTin1UVtX9YgNrJwpwyoUcbbCU5aUsJ9p83_B2_gE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/20 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sun, Dec 19, 2010 at 08:40:17PM +0300, Alexey Charkov wrote:
>> +config ARCH_VT8500
>> + ? ? bool "VIA/WonderMedia 85xx"
>> + ? ? select CPU_ARM926T
>> + ? ? select GENERIC_GPIO
>> + ? ? select ARCH_HAS_CPUFREQ
>> + ? ? select GENERIC_TIME
>
> Everything looks good, except for the above. ?You don't need to select
> GENERIC_TIME - it doesn't exist anymore.

Ok, that was an old copy-paste. Will resubmit a revised version in a moment.

> It's also good to see that you've picked up on registering clocksources
> with the _hz/_khz functions.

Yes, these are quite handy. I will also check if my previously spotted
performance issues with sched_clock are relieved with the latest
clocksource-related instrumentary in 'devel': maybe it wasn't all due
to evil busy-waiting on counter-to-bus synchronization. However, that
would probably be worth a separate small patch.

Thanks,
Alexey
