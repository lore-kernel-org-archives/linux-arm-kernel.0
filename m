From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Nov 2012 13:13:15 +0000
Subject: [PATCH V5 5/5] arm: mvebu: Added SMP support for Armada XP
In-Reply-To: <50ACC9A8.9060409@free-electrons.com>
References: <1353446150-10088-1-git-send-email-gregory.clement@free-electrons.com>
 <1353446150-10088-6-git-send-email-gregory.clement@free-electrons.com>
 <20121121104132.GD11990@mudshark.cambridge.arm.com>
 <50ACC198.5030300@free-electrons.com>
 <20121121122251.GI11990@mudshark.cambridge.arm.com>
 <20121121122610.GM3290@n2100.arm.linux.org.uk>
 <50ACC9A8.9060409@free-electrons.com>
Message-ID: <20121121131315.GJ11990@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 12:31:36PM +0000, Gregory CLEMENT wrote:
> On 11/21/2012 01:26 PM, Russell King - ARM Linux wrote:
> > On Wed, Nov 21, 2012 at 12:22:51PM +0000, Will Deacon wrote:
> >> Sorry, my mistake (I was thinking on my feet) since secondary_startup is
> >> declared in a C file, right? How about:
> >>
> >> 	ldr	lr, =secondary_startup
> >> 	b	ll_set_cpu_coherent
> > 
> > Why?  Do we really want LR to be the _virtual_ address?  No we don't,
> > because secondary_startup expects to be called with the MMU off.
> > 
> > So I go back to my original comment.  What's wrong with:
> > 
> > 	bl	ll_set_cpu_coherent
> > 	b	secondary_startup
> > 
> > ?
> 
> Nothing wrong, it works perfectly.
> Whereas indeed the code proposed by Will didn't work very well.
> I will take Russell's suggestion.

Fine by me. Somehow I thought this was jumping into C but it's actually way
earlier than that.

Sorry for the confusion,

Will
