From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 19 Aug 2013 01:02:00 +0200
Subject: [RFC v1 5/5] ARM: mvebu: add board init for Armada 1500
In-Reply-To: <201308172112.30773.arnd@arndb.de>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376682098-10580-6-git-send-email-sebastian.hesselbarth@gmail.com>
 <201308172112.30773.arnd@arndb.de>
Message-ID: <52115268.4010100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2013 09:12 PM, Arnd Bergmann wrote:
> On Friday 16 August 2013, Sebastian Hesselbarth wrote:
>> +config MACH_ARMADA_1500
>> +       bool "Marvell Armada 1500 boards"
>> +       select ARMADA_1500_CLK
>> +       select ARM_GIC
>> +       select CACHE_L2X0
>> +       select CPU_PJ4B
>> +       select DW_APB_TIMER_OF
>> +       select LOCAL_TIMERS if SMP
>> +       select HAVE_ARM_TWD if LOCAL_TIMERS
>> +       select HAVE_SMP
>> +       select PINCTRL_ARMADA_1500
>
> Hmm, I also noticed that this enables support for both the Cortex-A9
> (using GIC and L2X0) and the PJ4 based variants of Armada 1500. I
> wonder if we should have separate options for the two. E.g. if you
> want to build a kernel for the Chromecast, there would be no need to
> enabled PJ4 support.
>
> I have not been able to find out which core is used in most of the
> production Google TV boxes.

AFAIK, there is Armada 1500 (88de3100) used in every Google TV 2nd Gen
devices, some older multimedia boxes also used Armada 1000 (88de3010),
and Chromecast comprises Armada 1500-mini (88de3005).

We should be able to find out if it is PJ4B or Cortex-A9 by checking
any CPU register?

Sebastian
