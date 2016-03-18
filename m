From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 18 Mar 2016 10:27:56 +0100 (CET)
Subject: [RESEND PATCH v4 1/5] clocksource: move some enums and marcos
 to header file for arm_arch_timer
In-Reply-To: <1458288053-29031-2-git-send-email-fu.wei@linaro.org>
References: <1458288053-29031-1-git-send-email-fu.wei@linaro.org>
 <1458288053-29031-2-git-send-email-fu.wei@linaro.org>
Message-ID: <alpine.DEB.2.11.1603181016560.3978@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Mar 2016, fu.wei at linaro.org wrote:

Subject: clocksource: move some enums and marcos to header file for arm_arch_timer

That sucks.

1) The prefix is crap. It suggests this is about the generic clocksource code

   clocksource/drivers/arm_arch_timer:

   Is the proper prefix

2) Sentences start with upper case letters

3) What exactly are 'marcos' ?

So a useful subject line would be;

clocksource/drivers/arm_arch_timer: Move enums and defines to header file
   
> From: Fu Wei <fu.wei@linaro.org>
> 
> The patch sorts out the code for arm_arch_timer:

What does it sort out? Nothing, AFAICT.

You miss to explain WHY you are doing this. The list below is completely
useless because one can see that from the patch.

So this wants to be something like this:

To support the arm_arch_timer via ACPI we need to share defines and enums
between the driver and the ACPI parser code.

Split out the relevant defines and enums into arm_arch_timer.h. No functional
change.

>     (1)move enum ppi_nr to the header file
>     (2)move "ARCH_*_TIMER" marcos to the header file
>     (3)add enum spi_nr in the header file, and use it in the driver
>     (4)add ARCH_WD_TIMER and ARCH_TIMER_MEM_MAX_FRAME marcos

So this does 3 things at once.

   1) Move existing defines and enums

   2) Add a new enum and convert the driver to use it

   3) Add new defines without using them

So this needs to be seperate

   #1) This patch

   #2) Seperate patch which adds the new enum and converts the places in the
       driver

   #3) This needs to go into the patch which actually uses the defines.

Thanks,

	tglx
