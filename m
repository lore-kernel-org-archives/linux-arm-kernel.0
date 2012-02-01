From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 01 Feb 2012 12:34:29 +0100
Subject: cpu_relax in busy loops question
Message-ID: <4F292345.8070800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Linus,

While looking at the drivers/mfd/db8500-prcmu.c file I noticed:


  595         /* Grab the HW semaphore. */
  596         while ((readl(PRCM_SEM) & PRCM_SEM_PRCM_SEM) != 0)
  597                 cpu_relax();


I was wondering why is cpu_relax needed here as readl does a memory 
barrier ? I thought the cpu_relax function was related to the x86 to 
consume less power with an optimization of the "rep nop" loops or/and do 
a memory barrier.

Should a busy-loop be always with cpu_relax ?

Thanks
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
