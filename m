From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 08 Jun 2012 09:55:11 +0200
Subject: Overriding/concatenating kernel command-line with bootargs from dtb?
Message-ID: <2050174.dvvKJHKP0J@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I have a specific use case, where two boards using the same SoC have different 
UART speeds, which is something that I have specified in their corresponding 
dts files. In order to make sure people don't mess up the configuration, I 
prefer not to rely on the bootloader-supplied kernel-command line.

I was kind of expecting that ARM_ATAG_DTB_COMPAT + CMDLINE_EXTEND would 
actually concatenate the kernel command-line with the bootargs provided from 
dtb.

Is this something someone else would need? If so, shall we just make that 
happen when the two config symbols mentionned above are enabled, or shall we 
introduce a 4th kernel command line handling strategy?

Thank you for your answers.
-- 
Florian
