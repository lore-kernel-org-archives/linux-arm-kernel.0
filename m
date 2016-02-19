From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 19 Feb 2016 16:28:06 +0000
Subject: [PATCH] ARM: Allow MULTIPLATFORM to select XIP
In-Reply-To: <64215923.Y25jP5YYZ2@wuerfel>
References: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
 <3699765.F7sfuMCyKT@wuerfel>
 <HK2PR06MB05616AAF67B15C7A2BDC4F608AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <64215923.Y25jP5YYZ2@wuerfel>
Message-ID: <HK2PR06MB056181A22F655E6D4A11DEED8AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 Feb 2016, Arnd Bergmann wrote:
> 
> > But, now I see that PHYS_OFFSET is used all over the place as a hard
> > coded #define, hence your comment "which cannot patch the kernel image
> > at boot time"
> > 
> > So, I retract my thought...it has to be configured at build-time
> > (unless of course you turn it into a global variable everywhere...which
> >  might be an even bigger mess)
> > 
> 
> BTW, I've tried removing the patching in CONFIG_PHYS_VIRT and replaced it
> with references to __pv_phys_pfn_offset, which surprisingly only grew
> .text from 4901692 to 4904300 bytes, so the size overhead of doing this
> would be close to zero.
> 
> 	Arnd

Cool. If you come up with a patch, I'll give it a try.


Overall, I'd rather side with "Let me enable stuff even though it might not work automatically" as opposed to "Don't let me do anything unless it's simple and safe" (which kind of reminds me of Apple products)


Chris
