From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 16 Feb 2011 15:14:15 -0700 (MST)
Subject: [PATCH 00/11] OMAP2+: clock: add clockfw autoidle for iclks,
	OMAP2xxx
In-Reply-To: <b83b1717e83fc907a1caf589cc53badf@mail.gmail.com>
References: <20110216065030.22089.61217.stgit@twilight.localdomain>
	<b83b1717e83fc907a1caf589cc53badf@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1102161510410.29817@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra

On Wed, 16 Feb 2011, Rajendra Nayak wrote:

> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org
> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf
> > Of Paul Walmsley
> > Sent: Wednesday, February 16, 2011 12:23 PM
> >
> > This series also ensures that all clock autoidle is disabled during
> > boot and only re-enabled if CONFIG_PM is enabled.
> 
> This does not seem to be the case. Maybe something like the
> below patch is what is missing..

Thanks for the review, you are absolutely right.  Rather than the patch 
you sent, and since mach-omap2/pm.c is compiled in even if !CONFIG_PM, 
I'd propose a different approach.  Until we can sort out the 
CONFIG_PM/pm.c issue, probably it would make more sense to move the 
autoidle-enable as part of CONFIG_OMAP_RESET_CLOCKS.  Will send a patch in 
reply to the original thread.


- Paul
