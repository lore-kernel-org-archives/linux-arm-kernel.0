From: schwab@linux-m68k.org (Andreas Schwab)
Date: Mon, 02 Apr 2012 18:29:15 +0200
Subject: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map;
 use irq_alloc_desc() instead
In-Reply-To: <m2iphj3zxr.fsf@igel.home> (Andreas Schwab's message of "Sun, 01
 Apr 2012 23:27:44 +0200")
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home>
Message-ID: <m2hax2qeqs.fsf@igel.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> Grant Likely <grant.likely@secretlab.ca> writes:
>
>> This patch drops the powerpc-specific irq_map table and replaces it with
>> directly using the irq_alloc_desc()/irq_free_desc() interfaces for allocating
>> and freeing irq_desc structures.
>
> This breaks irqs on PowerMac G5.  I see lost irq errors from the sata
> driver.

When I revert a09b659cd68c10ec6a30cb91ebd2c327fcd5bfe5 ("genirq: Fix
long-term regression in genirq irq_set_irq_type() handling") on top of
3.4-rc1 the sata irq errors disappear, but I see a lot of spurious
interrupts.  Also the X server is broken somehow, though I don't know
whether that is related or a different bug.

Andreas.

-- 
Andreas Schwab, schwab at linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
