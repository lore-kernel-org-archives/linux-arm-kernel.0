From: admar.schoonen@prodrive-technologies.com (Admar Schoonen)
Date: Tue, 5 Aug 2014 13:36:44 +0000
Subject: MMC + DMA too fast for CPU?
Message-ID: <228FA701DC8C984DB8BA0243BEA01CAB015CC135@exc02.bk.prodrive.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I have an LPC3250 (ARM926, ~ 200 MHz) with eMMC running Linux 3.12.20. By default, it runs the MMC (with MMCI driver) in PIO mode and I need to set the MMC clock very low ( ~ 400 kHz or lower) to get reliable operation. This gives me about 200 KB/s throughput.

I have enabled DMA with the patch from http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/143995.html and some small modifications here and there and MMC now seems to run fine at 1.5 MHz. This gives me a throughput of about 660 KB/s.

If I clock the MMC higher than that, I get lots of errors (ETIMEDOUT, EIO etc) when executing the mmc_tests. Could that be caused by the CPU being too slow to handle the interrupts?

And is this performance of 660 KB/s indeed what could be expected of such a CPU? Or must there be something else that is limiting the system?

Thanks in advance and please keep me on CC as I am not subscribed to this list.

Kind regards,

Admar Schoonen 
Engineer 

www.prodrive-technologies.com 

Disclaimer: The content of this e-mail is intended solely for the use of the Individual or entity to whom it is addressed. If you have received this communication in error, be aware that forwarding it, copying it, or in any way disclosing its content to any other person, is strictly prohibited. If you have received this communication in error, please notify the author by replying to this e-mail immediately.
