From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 14 Jun 2013 11:00:01 -0700
Subject: [PATCH] ARM: mmu: Add debug_ll_io_init() mappings to early
 mappings
In-Reply-To: <20130614164524.GA3399@codeaurora.org>
References: <1371000607-1787-1-git-send-email-sboyd@codeaurora.org>
 <CAL_JsqLJ7ZD9-VR+vgOZZ_q-RD6FCDvKPSNSCjAADxy94SU1Xg@mail.gmail.com>
 <20130612172146.GB10823@codeaurora.org>
 <51BB15DA.8020302@gmail.com> <20130614164524.GA3399@codeaurora.org>
Message-ID: <20130614180001.GB3399@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14, Stephen Boyd wrote:
> On 06/14, Rob Herring wrote:
> > On 06/12/2013 12:21 PM, Stephen Boyd wrote:
> > > On 06/11, Rob Herring wrote:
> > >> Can you use vm_reserve_area_early here or perhaps just call
> > >> iotable_init instead of create_mapping directly? I don't recall if
> > >> there was some reason I didn't do that.
> > >>
> > > 
> > > I had iotable_init() before but I thought it was better to have
> > > the ->caller argument say debug_ll_io_init() instead of
> > > iotable_init(). Shall I extract out the similar code?
> > 
> > Well, that's always welcome...
> > 
> > Another option would be use __builtin_return_address. That would change
> > vmallocinfo from showing iotable_init to the caller of iotable_init.
> > Arguably, knowing the caller would be better.
> > 
> 
> Ok sounds fair. I'll use iotable_init() and send a follow-up
> patch to make iotable_init() more informative.
> 

Well now I get paging_init() as the function because that's where
we're going to return to. That actually seems less informative.
I'll do the similar code extraction.
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
