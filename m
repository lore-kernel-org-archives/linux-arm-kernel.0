From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Apr 2016 17:11:01 +0100
Subject: [PATCH 4/7] io-64-nonatomic: Add relaxed accessor variants
In-Reply-To: <4658440.AyDy7GFvoa@wuerfel>
References: <cover.1460391217.git.robin.murphy@arm.com>
 <5485134.l18Z1dlVmn@wuerfel> <571E3781.3070609@arm.com>
 <4658440.AyDy7GFvoa@wuerfel>
Message-ID: <20160425161101.GC2122@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 05:41:21PM +0200, Arnd Bergmann wrote:
> On Monday 25 April 2016 16:28:01 Robin Murphy wrote:
> > >>>
> > >>> We _could_ - indeed I started doing that, but then decided that the
> > >>> obfuscation of horrible macro-templated functions wasn't worth saving a
> > >>> couple of hundred bytes in some code that isn't exactly difficult to
> > >>> maintain and has needed touching once in 4 years.
> > >>>
> > >>> If you did want to go down the macro route, I may as well also generate both
> > >>> lo-hi and hi-lo headers all from a single template, it'd be really clever...
> > >>> <alarm bells>
> > >>
> > >> I certainly wasn't suggesting any more than the obvious macroisation,
> > >> but I'll leave it up to Arnd, as I think this falls on his lap.
> > >
> > > I'd prefer the open-coded variant as well.
> > 
> > By that, do you mean sticking with the smmu_writeq() implementation in 
> > the driver and dropping this patch, or merging this patch as-is without 
> > further macro-magic?
> > 
> 
> Sorry, that was really ambiguous on my end. I meant leaving patch 4/7
> as it is in the version you posted.

I'm happy with that. Could I have your ack, so that I can queue it with
the related SMMU patches, please?

Will
