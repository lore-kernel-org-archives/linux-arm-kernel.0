From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 16 Mar 2012 18:14:46 +0100
Subject: [PATCH] mfd: pcap: depend on arch-pxa
In-Reply-To: <1331011808-28307-1-git-send-email-haojian.zhuang@gmail.com>
References: <1331011808-28307-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20120316171446.GF20524@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Tue, Mar 06, 2012 at 01:30:08PM +0800, Haojian Zhuang wrote:
> drivers/mfd/ezx-pcap.c: In function ?pcap_isr_work?:
> drivers/mfd/ezx-pcap.c:206:2: error: implicit declaration of function
> ?pxa_irq_to_gpio?
> make[2]: *** [drivers/mfd/ezx-pcap.o] Error 1
You get that error once you replace irq_to_gpio() with pxa_irq_to_gpio().


> PCAP driver invokes irq_to_gpio() directly. This function isn't common
> function in most silicons. PCAP driver is enabled for EZX machine with
> arch-pxa. Now use pxa_irq_to_gpio() instead.
> 
> It's only a workaround for this issue. Acutally the best solution is
> using thread irq to fix this issue.
How would that fix the problem ? Defining irq_to_gpio for the PXA arch sounds
like a better option. I don't particularily like this patch as it restricts
the pcap driver quite a lot.
Would you be able to look at fixing the PXA gpio.h instead ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
