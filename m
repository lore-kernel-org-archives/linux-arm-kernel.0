From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Mon, 23 Mar 2015 01:24:51 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <20150322165710.GO8656@n2100.arm.linux.org.uk>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
 <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
 <HK2PR06MB0561FE47407CA32AA8DDEFCF8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUS84s=uLYVk8BtRoKFmBzw7aT1eQCfGF1nx22hTqf15A@mail.gmail.com>
 <HK2PR06MB05611C6D6CED1E32F4617D158A010@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20150320222320.GL8656@n2100.arm.linux.org.uk>
 <HK2PR06MB05611E6828E494FB938179658A0F0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20150322165710.GO8656@n2100.arm.linux.org.uk>
Message-ID: <HK2PR06MB056105B026481446243452FC8A0D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So, allowing both XIP_KERNEL=y and SMP=y is quite correct: however, folk need to understand that the SMP option _must_ match the hardware they're booting on.

OK. I think I have some studying to do before I try to attempt XIP on another platform. Or at least, give some guidance to the chip designers if XIP Linux will be a desired operational mode.


> If you consider that the SMP alternatives table is 0x5ee0 bytes long for my iMX6 kernel, and that each entry is 8 bytes, -snip-

Well there goes that idea.


> Yes, that makes sense if we agree that we want to have multi-platform XIP kernels.

My initial ambition was to simply understand what the minimum Kconfig changes were needed to build XIP on the current upstream kernel.
I'm not convinced XIP and multi-platform really make sense together (unless ARM comes up with a new supper speedy configurable cache system just for DDR reads, but DDR writes have to be done from different address location).


I guess my first goal is to make sure the existing XIP_KERNEL code doesn't get yanked out because no one thought it was being used.

Chris
