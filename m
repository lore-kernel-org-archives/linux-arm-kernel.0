From: schwab@linux-m68k.org (Andreas Schwab)
Date: Sun, 01 Apr 2012 23:27:44 +0200
Subject: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map;
 use irq_alloc_desc() instead
In-Reply-To: <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 (Grant Likely's message of "Thu, 16 Feb 2012 02:09:07 -0700")
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
Message-ID: <m2iphj3zxr.fsf@igel.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely <grant.likely@secretlab.ca> writes:

> This patch drops the powerpc-specific irq_map table and replaces it with
> directly using the irq_alloc_desc()/irq_free_desc() interfaces for allocating
> and freeing irq_desc structures.

This breaks irqs on PowerMac G5.  I see lost irq errors from the sata
driver.

Note that the breakage only started after the series was merged into
mainline.  But when transplanted upon the parent of the merge this is
the commit that was blamed by bisect.  So something changed between
v3.3-rc3 and the merge of this series that broke it.

Andreas.

-- 
Andreas Schwab, schwab at linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
