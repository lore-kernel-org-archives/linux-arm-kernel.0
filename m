From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 20 Jan 2012 16:03:28 +0000
Subject: [PATCH] ARM: ux500: Initialize irq affinity
In-Reply-To: <CACRpkdYgT-Q+ZEzhjOaOb_2Pihx0-pMXo+Dc-CESDT7BAWAOqg@mail.gmail.com>
References: <1327064356-3603-1-git-send-email-per.xx.fransson@stericsson.com>
 <20120120130310.GO1068@n2100.arm.linux.org.uk>
 <CACRpkdYgT-Q+ZEzhjOaOb_2Pihx0-pMXo+Dc-CESDT7BAWAOqg@mail.gmail.com>
Message-ID: <4F199050.5080702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/01/12 15:45, Linus Walleij wrote:
> On Fri, Jan 20, 2012 at 2:03 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Fri, Jan 20, 2012 at 01:59:16PM +0100, Per Fransson wrote:
>>> Use irq_set_affinity() to initialize the kernel view of irq affinity
>>> when programming the GIC registers.
>>
>> Why is this necessary?
> 
> Necessary: we don't quite know. (Maybe should have been RFC, but
> this patch is better than being silent of it...)
> 
> On the Ux500 all shared peripheral IRQs (32 thru 127) are delivered
> to CPU0 (hardwired, will not work on CPU1), I have heard that this
> is sort of what everybody does but don't know for sure. (Marc?)

Not as far as I know. My platforms seems to happily deliver interrupts
on other cores by setting the SMP affinity (just tested on my EB11MP).

	M.
-- 
Jazz is not dead. It just smells funny...
