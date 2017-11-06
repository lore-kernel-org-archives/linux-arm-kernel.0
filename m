From: james.morse@arm.com (James Morse)
Date: Mon, 06 Nov 2017 18:43:38 +0000
Subject: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use fixmap
In-Reply-To: <1509559730.30483.19.camel@hpe.com>
References: <20171031153832.17746-1-james.morse@arm.com>	
 <59F9E119.6040700@arm.com> <20171101153043.xgzepqbxsblmppp5@pd.tnic>
 <1509559730.30483.19.camel@hpe.com>
Message-ID: <5A00AD5A.1070601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/17 18:20, Kani, Toshimitsu wrote:
> On Wed, 2017-11-01 at 16:30 +0100, Borislav Petkov wrote:
>> On Wed, Nov 01, 2017 at 02:58:33PM +0000, James Morse wrote:
>>> Does anyone have an x86 machine that does firmware-first using NOTIFY_NMI?

>> AFAIK, the only one who has access to a reportedly somewhat working GHES
>> implementation is Toshi. CCed.
> 
> Thanks for the heads-up.  My x86 system only supports GHES with SCI
> error sources.  It uses MCE for synchronous error events.
> 
> So, for x86 SCI error sources:
> 
> Tested-by: Toshi Kani <toshi.kani@hpe.com>

Thanks Toshi!


> nit: I think ghes_ioremap_pfn_[nmi|irq] should be renamed since they no
> longer use ioremap. 

I thought that would be too noisy...

I have some more rework to do in here before we can merge the other arm64 RAS
stuff, I can take that into account then.


Thanks,

James
