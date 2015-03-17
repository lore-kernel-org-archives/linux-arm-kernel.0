From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 17 Mar 2015 13:46:29 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
Message-ID: <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

> Besides, I think a multi-platform XIP (or nommu) kernel is possible, as long as XIP_PHYS_ADDR (or PHYS_OFFSET) is suitable for all platforms included

Possible...but...maybe pointless. If you're doing XIP, then most likely you've got a specific platform that you are trying to do as much as you can in as little (RAM) as possible.

Was ARCH_MULTIPLATFORM really trying to fix some huge existing problem? Or was it more of a 'here's a cute thing we could do'?
In my mind, an SoC by nature is used for specific embedded product and you could care less if the binary runs on anything else. Of course the range of SoCs that can run Linux now a days varies greatly, so I don't think you can put them all in the same category like ARCH_MULTIPLATFORM was trying to do.


> Perhaps ARCH_MULTIPLATFORM should be replaced by ARCH_ARM_NEWWORLD almost everywhere, and (new) ARCH_MULTIPLATFORM should be reserved (if needed at all) to protect features that are not compatible with running on multiple machines?

That's not bad. I think it still comes down to if you want to build XIP, you don't care about ARCH_MULTIPLATFORM support, and the XIP_PHYS_ADDR (and PHYS_OFFSET) you need to use is device specific anyway.

It also looks like a couple month ago someone also pointed out that just because the base core is the same, that doesn't mean all the erratas are the same, and ARCH_MULTIPLATFORM doesn't fit there as well.

Chris
