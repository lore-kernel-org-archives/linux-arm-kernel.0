From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 11 May 2012 08:47:17 -0500
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120511122547.GE17453@mudshark.cambridge.arm.com>
References: <87k40nzi3i.fsf@ti.com> <4FA8FCFF.40105@ti.com>
 <4FA9588E.9020906@ti.com> <87sjfal65t.fsf@ti.com> <4FAA4DB9.8060504@ti.com>
 <4FAAB1A3.9040806@ti.com> <4FAAC549.6010206@ti.com> <4FAAE564.6040708@ti.com>
 <20120510084422.GB27276@mudshark.cambridge.arm.com> <4FAC0F05.3060803@ti.com>
 <20120511122547.GE17453@mudshark.cambridge.arm.com>
Message-ID: <4FAD1865.70003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will

On 05/11/2012 07:25 AM, Will Deacon wrote:
> On Thu, May 10, 2012 at 07:55:01PM +0100, Jon Hunter wrote:
>> Hi Will,
> 
> Hi Jon,
> 
>> For my testing I have just been reading the PM_EMU_PWRSTST register which shows the power state of the EMU power domain. It should read 3 when the power domain is ON and 0 when it is off. I did something like the following (dumping all EMU clock and power domain registers).
> 
> I figured I may as well take perf for a spin and see how I got on. The good
> news is that the hwmod bits all seem to work as before and the correct IRQs
> are requested:
> 
> root at florentine-pogen:~# cat /proc/interrupts
>            CPU0       CPU1
>  29:      44527      17916       GIC  twd
>  33:          0          0       GIC  arm-pmu
>  34:          0          0       GIC  arm-pmu
> 
> But, unfortunately, as you can see from the above, I just can't persuade them
> to fire. The PMU counters do tick, but they happily increment through zero
> without us realising. I retested with my perf/omap4 branch to make sure my
> board is ok, and the irqs do fire there.
> 
> Any ideas?

Do you disable OMAP2/3 support in the kernel config, so that CPU_HAS_PMU
is enabled?

Cheers
Jon
