From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Tue, 5 Apr 2011 13:22:33 +0100 (BST)
Subject: [RFC PATCH v2] Current status, suspend-to-disk support on ARM
In-Reply-To: <alpine.DEB.2.00.1104041424310.690@localhost6.localdomain6>
References: <alpine.DEB.2.00.1104041424310.690@localhost6.localdomain6>
Message-ID: <alpine.DEB.2.00.1104051315240.690@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Updated version of yesterday's core ARM hibernation code bits.

I've found that the use of cpu_switch_mm() breaks resume on OMAP3; leaving 
it out for now. It's unnecessary for direct resume (via kernel command 
line or TuxOnIce), only needed for uswsusp.

Also, me bad, apologies for posting refactored code one too early ... I've 
tried many ways of getting the actual swsusp_arch_suspend/resume 
entrypoints to be C code (and only the absolute essentials assembly), but 
for the case of swsusp_arch_suspend, assembly entry is mandatory because 
the framework relies on resuming into to the caller (i.e. no change can be 
made to the return address / LR reg before storing it, that makes it 
impossible to use a C wrapper function).

Thanks for any thoughts, feedback, reviews on this.

FrankH.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hibernate-core-05Apr2011.patch
Type: text/x-diff
Size: 9758 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110405/ed330412/attachment-0001.bin>
