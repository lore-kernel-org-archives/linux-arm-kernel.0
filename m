From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 31 May 2012 11:23:09 +0300
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <4FC6E5B2.2010700@codeaurora.org>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5DFCF.1020606@codeaurora.org>
 <20120530194059.GA13243@gmail.com>
 <4FC6E5B2.2010700@codeaurora.org>
Message-ID: <20120531082309.GP8026@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 05:29:54AM +0200, Saravana Kannan wrote:
> On 05/30/2012 12:40 PM, Mike Turquette wrote:
> > On 20120530-01:52, Stephen Boyd wrote:
> >> On 5/29/2012 2:58 AM, Peter De Schrijver wrote:
> >>> Add an extension API for clocks. This allows clocktypes to provide extensions
> >>> for features which are uncommon and cannot be easily mapped onto normal clock
> >>> framework concecpts. eg: resetting blocks, configuring clock phase etc.
> >>
> >> This seems rather generic. Why not add more specific APIs/concepts like
> >> clk_reset(), clk_set_phase(), etc.? If they don't map, maybe we should
> >> make them map.
> >>
> >
> > I also wonder if exposing some of these knobs should be done in the
> > basic clock types.  Meaning that instead of having additional calls in
> > the clk.h API those calls could be exposed by the basic clock types that
> > map to the actions.
> >
> > The question that needs to be answered is this: do generic drivers need
> > access to these additional functions (clk.h) or just the platform code
> > which implements some of the clock logic (basic clock types&
> > platform-speciic clock types).
> 
> One of the main reason for the common clock framework is so that each 
> platform doesn't have it's own extension and have mostly similar code 
> repeat all over the place. So, having clock APIs outside of clk.h 
> doesn't make sense when we look at the direction we want the code base 
> to proceed in.

I don't think this will lead to 'mostly similar code repeat all over the
place'. I don't know of any intree SoC which has a similar requirement.
So which code duplication would this cause?

Cheers,

Peter.
