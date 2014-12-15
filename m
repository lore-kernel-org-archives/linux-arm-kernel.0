From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Dec 2014 17:20:40 +0000
Subject: [PATCH 2/4] iommu: add ARM LPAE page table allocator
In-Reply-To: <BN3PR0301MB12199C5CAD33E745CC7E51F4EA6F0@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
 <1417089078-22900-3-git-send-email-will.deacon@arm.com>
 <BN3PR0301MB12198CE5D736CDC6A221EDC2EA790@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <20141205184802.GH1203@arm.com>
 <BN3PR0301MB1219D3161E4E9DB314FDD8FAEA6E0@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <20141215133020.GJ20738@arm.com>
 <BN3PR0301MB12199C5CAD33E745CC7E51F4EA6F0@BN3PR0301MB1219.namprd03.prod.outlook.com>
Message-ID: <20141215172040.GQ20738@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 04:43:59PM +0000, Varun Sethi wrote:
> > Sure we can support 48-bit VAs with 64k pages. Why do you think we can't?
> > 
> > [varun]  My concern was with respect to the bits per level, which is 
> > uneven for the 64 K page sizes. Just wondering how would things work 
> > with 64K pages when we do a 3 level page lookup.
> 
> Well, it's uneven (9) for the 4k case too. Do you actually see an issue here?
> 
> 48-bit VA with 64k pages gives us:
> 
>   va_bits = (48 - 16) = 32
>   bits_per_level = (16 - 3) = 13
>   levels = ceil(32/13) = 3
> 
> so the starting level is 1, which resolves 32-(13*2) = 6 bits.
> 
> Does that make sense?
> 
> [[varun]]Yes, but what I meant was, is that in case of 4K pages you have 9
> bits per level, but for 64K pages you have 6 bits for the first  level and
> 13 each for second and third. So, bits per level would not work in case of
> 64 K pages?

The current code takes this into account.

Will
