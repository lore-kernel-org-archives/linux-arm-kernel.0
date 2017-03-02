From: rafal@milecki.pl (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 2 Mar 2017 18:46:10 +0100
Subject: DIfferent BogoMIPS value after bbaa06702719
 ("clocksource/drivers/arm_global_timer: Register delay timer")
In-Reply-To: <20170302141334.GM21222@n2100.armlinux.org.uk>
References: <d22ec429-1a71-e56f-e1d7-28b066be8c1b@milecki.pl>
 <20170302141334.GM21222@n2100.armlinux.org.uk>
Message-ID: <8d136a2c-c306-e8c8-780a-f55cb891f6e0@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2017 03:13 PM, Russell King - ARM Linux wrote:
> On Thu, Mar 02, 2017 at 02:36:23PM +0100, Rafa? Mi?ecki wrote:
>> Hi,
>>
>> I just updated kernel on my SmartRG SR400ac (bcm4708-smartrg-sr400ac.dts) from
>> 4.4 to 4.9 and noticed that this part of the log:
>> [    0.020820] Calibrating delay loop... 1594.16 BogoMIPS (lpj=7970816)
>> (...)
>> [    0.190806] Brought up 2 CPUs
>> [    0.200022] SMP: Total of 2 processors activated (3188.32 BogoMIPS).
>>
>> became:
>> [    0.027082] Calibrating delay loop (skipped), value calculated using timer frequency.. 800.00 BogoMIPS (lpj=4000000)
>> (...)
>> [    0.078858] Brought up 2 CPUs
>> [    0.088254] SMP: Total of 2 processors activated (1600.00 BogoMIPS).
>>
>> This is caused by commit bbaa06702719 ("clocksource/drivers/arm_global_timer:
>> Register delay timer").
>>
>> Is this something expected?
>
> Yes.
>
>> Or should I be worried about this? I'm aware it's just BogoMIPS, but I
>> still prefer to ask :)
>
> It's *bogus*.  Bogomips is the calibration value that the kernel uses
> to achieve delays.  It has nothing to do with the speed of the CPU on
> modern systems that use a timer instead.  (In that case, it's a
> calibration value for the timer, rather than a calibration value for
> the number of software loops required to achieve a delay.)

Now I can sleep calm ;) thanks!
