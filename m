From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 19 Feb 2016 15:36:23 +0000
Subject: [PATCH] ARM: Allow MULTIPLATFORM to select XIP
In-Reply-To: <3699765.F7sfuMCyKT@wuerfel>
References: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
 <2413859.DaWDFlIaaB@wuerfel>
 <HK2PR06MB05613CF6C996BF8BD459842E8AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <3699765.F7sfuMCyKT@wuerfel>
Message-ID: <HK2PR06MB05616AAF67B15C7A2BDC4F608AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 Feb 2016, Arnd Bergmann wrote:

> For PHYS_OFFSET, parsing the DT doesn't help at all because we only
> need it for XIP_KERNEL (more or less at least) which cannot patch
> the kernel image at boot time, so knowing that the address is wrong
> also doesn't help you.
> 
> 	Arnd

OK, at first I was thinking that PHYS_OFFSET was only used early in boot as a pointer to valid RAM before the DT was read (in head.S and head-nommu.S). Hence, you could pass in the pointer in via another CPU register like the DT pointer is passed in.

But, now I see that PHYS_OFFSET is used all over the place as a hard coded #define, hence your comment "which cannot patch the kernel image at boot time"

So, I retract my thought...it has to be configured at build-time (unless of course you turn it into a global variable everywhere...which might be an even bigger mess)


Chris
