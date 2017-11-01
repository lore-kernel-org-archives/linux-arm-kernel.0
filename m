From: toshi.kani@hpe.com (Kani, Toshimitsu)
Date: Wed, 1 Nov 2017 18:20:46 +0000
Subject: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use fixmap
In-Reply-To: <20171101153043.xgzepqbxsblmppp5@pd.tnic>
References: <20171031153832.17746-1-james.morse@arm.com>
 <59F9E119.6040700@arm.com> <20171101153043.xgzepqbxsblmppp5@pd.tnic>
Message-ID: <1509559730.30483.19.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-11-01 at 16:30 +0100, Borislav Petkov wrote:
> On Wed, Nov 01, 2017 at 02:58:33PM +0000, James Morse wrote:
> > Does anyone have an x86 machine that does firmware-first using NOTIFY_NMI?
> 
> AFAIK, the only one who has access to a reportedly somewhat working GHES
> implementation is Toshi. CCed.

Thanks for the heads-up.  My x86 system only supports GHES with SCI
error sources.  It uses MCE for synchronous error events.

So, for x86 SCI error sources:

Tested-by: Toshi Kani <toshi.kani@hpe.com>

nit: I think ghes_ioremap_pfn_[nmi|irq] should be renamed since they no
longer use ioremap. 

-Toshi
