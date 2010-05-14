From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 14 May 2010 06:35:50 +0100
Subject: [PATCH 11/11] ARM: S5P6440: Remove redundant defines
In-Reply-To: <20100513090608.GA5382@n2100.arm.linux.org.uk>
References: <1273710481-14856-1-git-send-email-kgene.kim@samsung.com>
	<AANLkTimTm_Vxvb2xvJnVxTxUaYguFgGeaWGypzA1yjwM@mail.gmail.com>
	<20100513020236.GS6684@trinity.fluff.org>
	<AANLkTilIvm2AlZeh_1cdcgZFFL5YuJUnYiytXA2tZktB@mail.gmail.com>
	<20100513090608.GA5382@n2100.arm.linux.org.uk>
Message-ID: <20100514053550.GP26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 13, 2010 at 10:06:08AM +0100, Russell King - ARM Linux wrote:
> On Thu, May 13, 2010 at 01:54:12PM +0900, Kyungmin Park wrote:
> > On Thu, May 13, 2010 at 11:02 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> > > 1) It takes two lines of code, where one is sufficient.
> > >
> > > 2) You only have to look in the relevant .c file to find out the
> > > ? value instead of tracking down a header. This makes it easier
> > > ? to verify the value against the manual and easier to compare
> > > ? against simialr code.
> > 
> > Then define it at c code and use the macro. I also don't like the
> > hard-coded values.
> 
> I'm almost with Ben on this; but we can do better to satisfy both camps.
> 
> 	.ctrlbit	= 1 << 2, /* CLKCON_MEM0_HCLK_NFCON */

As a note, the following awk will do that to this patch:

#!/bin/awk

{
    if ($0 ~ /^-.*ctrlbit*/) {
	last = $4;
	gsub(/,/,"",last)
	print $0;
    } else if ($0 ~ /^\+.*ctrlbit*/) {
	print $0 " /* " last " */";
    } else {
	print $0 default;
    }
}

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
