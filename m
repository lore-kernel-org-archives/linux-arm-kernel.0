From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 02 Oct 2015 17:55:13 +0100
Subject: [PATCH] arm-soc: Add Sigma Designs Tango4 port
In-Reply-To: <560EB1EC.3020403@free.fr> (Mason's message of "Fri, 2 Oct 2015
 18:33:48 +0200")
References: <560EAA7C.3070302@free.fr> <yw1xoaghl099.fsf@unicorn.mansr.com>
 <560EB1EC.3020403@free.fr>
Message-ID: <yw1xfv1tky6m.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

>>> +		uart0 {
>>> +			compatible = "ralink,rt2880-uart";
>>> +			reg = <0x10700 0x100>;
>>> +			clock-frequency = <7372800>;
>>> +			reg-shift = <2>;
>>> +/*			fifo-size = <16>; BROKEN */
>> 
>> Either fix whatever is broken or drop that line.
>
> I can't leave TODO reminders in the platform Kconfig?
> Even as comments?

Never mind, I've sent a patch fixing the problem.

>>> +		intc: intc at e000 {
>>> +			compatible = "sigma,tango-intc";
>> 
>> Why do you insist on using other names than the ones I've been using for
>> months?  Just want to leave your own mark on the code?
>
> You're using "sigma,smp8640-intc".
> The SMP8640 is a Tango3 (MIPS-based) platform.
> It makes no sense to have references to Tango3 in tango4.dtsi
> Aside from the CPU difference, Tango3 and Tango4 have a lot in common though.

It's commonplace to refer to peripherals by the earliest (supported)
chip using them.  This avoids naming conflicts if a future chip uses a
different component.  Some bits are incompatible even between different
devices in the tango3 family.

-- 
M?ns Rullg?rd
mans at mansr.com
