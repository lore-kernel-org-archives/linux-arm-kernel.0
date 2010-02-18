From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Feb 2010 08:51:25 +0000
Subject: Alignment Requirement for MT_MEMORY type
In-Reply-To: <B125D8217ABC4B43826503DE00A2D44910F4639A8D@SJEXCHCCR01.corp.ad.broadcom.com>
References: <B125D8217ABC4B43826503DE00A2D44910F4639A8D@SJEXCHCCR01.corp.ad.broadcom.com>
Message-ID: <20100218085125.GA848@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2010 at 04:33:00PM -0800, Henry Li wrote:
> Can someone tell me why there is a requirement for the virtual and physical
> addresses and size using MT_MEMORY memtype (where prot_l1=0) to be aligned
> to section boundary (1MB) in linux-2.6.32/arch/arm/mm/mmu.c/create_mapping
> during IO table init?

Because today SDRAM is always a whole number of MB, so its pointless
defining it in terms of 4K pages.  MT_MEMORY is not for general purpose
use, but only for setting up the initial kernel SDRAM mapping.
