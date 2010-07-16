From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Jul 2010 08:46:20 +0100
Subject: Question of kmap_atomic
In-Reply-To: <AANLkTilFvE0eyQS7jNQ77OYkJovJugjKRO-fPHjX8CB9@mail.gmail.com>
References: <AANLkTilFvE0eyQS7jNQ77OYkJovJugjKRO-fPHjX8CB9@mail.gmail.com>
Message-ID: <20100716074620.GA16124@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 09:41:59AM +0900, Minchan Kim wrote:
> I am stuck with looking at ARM's kmap_atomic.
> I am not familiar with ARM cache model.
> As I look the code, ARM seems to have a VIPT aliasing model.
> 
> Before Nicolas's 17ebba1fe, kmap_atomic always calls kmap_high_get to
> prevent aliasing problem of 7929eb9cf64 regardless of VIVT and VIPT.
> 
> But the patch made it to not call kmap_high_get when VIPT-aliasing
> model in CONFIG_DEBUG_HIGHMEM.
> Doesn't it cause aliasing problem as 7929eb9cf64 says, again?

There's various problems with highmem and VIPT aliasing caches, so we don't
permit its use with such caches.
