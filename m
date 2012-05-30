From: mturquette@ti.com (Mike Turquette)
Date: Wed, 30 May 2012 12:40:59 -0700
Subject: [RFC PATCH] clk: add extension API
In-Reply-To: <4FC5DFCF.1020606@codeaurora.org>
References: <1338285540-24407-1-git-send-email-pdeschrijver@nvidia.com>
 <4FC5DFCF.1020606@codeaurora.org>
Message-ID: <20120530194059.GA13243@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120530-01:52, Stephen Boyd wrote:
> On 5/29/2012 2:58 AM, Peter De Schrijver wrote:
> > Add an extension API for clocks. This allows clocktypes to provide extensions
> > for features which are uncommon and cannot be easily mapped onto normal clock
> > framework concecpts. eg: resetting blocks, configuring clock phase etc.
> 
> This seems rather generic. Why not add more specific APIs/concepts like
> clk_reset(), clk_set_phase(), etc.? If they don't map, maybe we should
> make them map.
> 

I also wonder if exposing some of these knobs should be done in the
basic clock types.  Meaning that instead of having additional calls in
the clk.h API those calls could be exposed by the basic clock types that
map to the actions.

The question that needs to be answered is this: do generic drivers need
access to these additional functions (clk.h) or just the platform code
which implements some of the clock logic (basic clock types &
platform-speciic clock types).

Regards,
Mike

> At the least it should be documented so that people know what it should
> be used for.
