From: alex.shi@linaro.org (Alex Shi)
Date: Tue, 10 Dec 2013 16:44:58 +0800
Subject: questions of cpuidle
In-Reply-To: <52A6C24B.3030800@linaro.org>
References: <52A5C846.30308@linaro.org> <52A5D0E0.7050201@linaro.org>
 <52A6B5BB.3060506@linaro.org> <52A6C24B.3030800@linaro.org>
Message-ID: <52A6D48A.4000507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2013 03:27 PM, Daniel Lezcano wrote:
> 
>> And does the wake up pass via GIC to CPU? If so, does the GIC need
>> keep awake when all cpu idle? If not, how the firmware give the
>> interrupt to CPU? And I am wondering if the deep idle cpu voltage get
>> to near 0. How the cpu get the interrupt signal?
> 
> If a deep idle state powers down the GIC, it is up to the PMU to proxy
> the interrupts. When an interrupt occurs, the PMU powers up the logic,
> including the GIC. The notifier call chain with cpu_suspend / cpu_resume
> will save and restore the GIC registers.
> 
> But this is hardware specific and will depend on how the PMU is
> implemented and how far it goes in the power management.
> 
> You have a good example in the drivers/cpuidle/cpuidle-ux500.c to
> understand with the comments how the interrupts are handled through the
> power management unit.
> 
> In the Xillinx documentation available on the web [1], the chapter 24.4
> gives the information about one kind of PMU.
> 
> I believe the mechanism is pretty similar on all the hardware but it is
> obfuscated by a generic power instruction like mwait.
> 
>   -- Daniel
> 
> [1]
> http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf
> 

Thanks a lot, Daniel. You are a expert of ARM cpu idle! :)

-- 
Thanks
    Alex
