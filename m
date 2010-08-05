From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 05 Aug 2010 12:48:39 +0200
Subject: [RFC PATCH] ARM: S5PC110: Remove VA_GPIO dependency from GPIO
	related functions
In-Reply-To: <20100805090315.GA20274@july>
References: <20100805090315.GA20274@july>
Message-ID: <018701cb348b$c67b77f0$537267d0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, August 05, 2010 11:03 AM Kyungmin Park wrote:

> To Ben,
> 
> Now I'm working on remove the dependency from VA_GPIO for the S5PC210 GPIOs.
> 
> S5PC210 has three GPIOs and has differnet address spaces.
> 
> Basic idea is remove static io mapping from iodesc and ioremap at each SoCs
> for their purpose. and pass the required information to external interrupt.
> The same mechanism is used to implement the GPIO interrupt features.
> 
> How do you think?

I really like the idea behind this patch. It is definitely a first step to
make the kernel independent of any static mappings, which would help creating
a single kernel for more than one SoC. 

The patch itself needs a little cleanup, but currently it is just an rfc. 
 
Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
