From: yangyingliang@huawei.com (Yang Yingliang)
Date: Fri, 13 Nov 2015 18:09:23 +0800
Subject: A problem about interrupt when booting a captured kernel
Message-ID: <5645B6D3.60305@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Marc


     The kexec will boot a captured kernel while the kernel panic. But
it boots failed if the kernel panic in handler function of PPI. The 
reason is that the PPI has not been 'eoi', other interrupts can not be 
handled when booting  the captured kernel.

     The kexec will call irq_eoi to end the irqs that have
IRQD_IRQ_INPROGRESS flag. But PPIs don't have this flag, so it won't be 
ended.

    Three ways to solve this problem we can think :
    1. Is there a way to reset gic like its_reset ?
    2. Can we add some flag for calling irq_eoi ?
    3. Just 'eoi' all PPIs without checking flags in kexec.

     Please give some advice.


Thanks
Yang
