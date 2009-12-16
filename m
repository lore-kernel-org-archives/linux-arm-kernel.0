From: Virupax.SS@Lntemsys.com (Virupax.SS at Lntemsys.com)
Date: Wed, 16 Dec 2009 18:26:40 +0530
Subject: Problem with CPU Data cache 
Message-ID: <OFD82C1D12.7D7C4E53-ON6525768E.00444887-6525768E.0046F2BF@lntemsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am using at91sam9g20 with 2.6.27 linux kernel and having problem in 
booting the kernel on one of the board.
I have analysed the arm register configuration and have seen by disabling 
the data cache in the kernel at the below locations, the kernel works fine 
on the bad board.

1) The "arch/arm/boot/compressed/head.S" which is used for decompressing 
the kernel and here i have changed the code manually to not to enable the 
data cache.
writing #0x0009 instead of #0x000d to the c1 register of the cp15.
2) The "arch/arm/kernel/head.S" file and for this the 
CONFIG_CPU_DCACHE_DISABLE kernel config option is sufficient to disable 
the data cache enabling.

If i dont do the first one , i get
Uncompressing 
Linux.............................................................
................................................
crc error
-- System halted

and if the first change is done and the seconds one is not done, then the 
kernel boots up but fails to mount the RFS. On doing both changes the 
kernel boots up fine with the RFS.
I feel like data chache disabling is needed only at places where there is 
some king of data decompression. 

It will be helpful if you can give some input on this issue.

Regards
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091216/57f856a4/attachment-0001.htm>
