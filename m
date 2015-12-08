From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 Dec 2015 12:40:17 +0000
Subject: [PATCH v3 3/7] arm64: split off early mapping code from
 early_fixmap_init()
In-Reply-To: <20151203121840.GB28731@leverpostej>
References: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447672998-20981-4-git-send-email-ard.biesheuvel@linaro.org>
 <20151203121840.GB28731@leverpostej>
Message-ID: <20151208124016.GH19612@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 12:18:40PM +0000, Mark Rutland wrote:
> Apologies that it's taken me so long to get around to this...
> 
> On Mon, Nov 16, 2015 at 12:23:14PM +0100, Ard Biesheuvel wrote:
> > This splits off and generalises the population of the statically
> > allocated fixmap page tables so that we may reuse it later for
> > the linear mapping once we move the kernel text mapping out of it.
> > 
> > This also involves taking into account that table entries at any of
> > the levels we are populating may have been populated already, since
> > the fixmap mapping might not be disjoint up to the pgd level anymore
> > from other early mappings.
> 
> As a heads-up, for avoiding TLB conflicts, I'm currently working on
> alternative way of creating the kernel page tables which will definitely
> conflict here, and may or may not supercede this approach.

Given that the Christmas break is around the corner and your TLB series
is probably going to take some time to get right, I suggest we persevere
with Ard's current patch series for 4.5 and merge the TLB conflict solution
for 4.6. I don't want us to end up in a situation where this is needlessly
blocked on something that isn't quite ready.

Any objections? If not, Ard -- can you post a new version of this, please?

Will
