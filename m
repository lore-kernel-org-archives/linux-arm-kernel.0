From: mingo@kernel.org (Ingo Molnar)
Date: Mon, 23 Feb 2015 17:37:06 +0100
Subject: [PATCH] clockevents: Add (missing) default case for switch blocks
In-Reply-To: <CAKohponv=aR7Ae_z7zbnDDeJ-mCFwdxB3wR-O4boBeMKYdUJLA@mail.gmail.com>
References: <20150220083842.GA20387@gmail.com>
 <20150220084807.GJ21418@twins.programming.kicks-ass.net>
 <20150220093659.GA23469@gmail.com>
 <20150220113753.GP5029@twins.programming.kicks-ass.net>
 <20150220114136.GA27483@gmail.com>
 <CAKohpokmCof2P8Un+i5eOS3BQhH_pMNATH4xkbbhw5TqJFEy9Q@mail.gmail.com>
 <20150220132220.GB28882@gmail.com>
 <CAKohpokEV7EatQROgzQBWPRPFEn8OsMo5EHa+q1FMwBESwiU3w@mail.gmail.com>
 <20150220140432.GA31928@gmail.com>
 <CAKohponv=aR7Ae_z7zbnDDeJ-mCFwdxB3wR-O4boBeMKYdUJLA@mail.gmail.com>
Message-ID: <20150223163706.GA12551@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 20 February 2015 at 19:34, Ingo Molnar 
> <mingo@kernel.org> wrote:
> >
> > * Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> >> Unused. Initially all clockevent devices are supposed 
> >> to be in this mode but later if another device 
> >> replaces an existing one, the existing one is put into 
> >> this mode.
> >
> > I'd suggest to rename it to MODE_INIT - at first glance 
> > it gave me the impression that it's some sort of API 
> > placeholder - i.e. an unused flag or so.
> 
> Sorry, if I wasn't able to clarify this earlier. The 
> impression you got at first glance is correct. And it 
> should be UNUSED only instead of INIT. Its not about if 
> the the device is initialized or not, but if it is used 
> or not. And that's why there is no callback for this in 
> the new per-mode callbacks.

Ok, could we rename it to something like DETACHED?

'UNUSED' really gives me the wrong impression - it's what 
we do for unused fields, unused ABI enumertion constants, 
etc.

> > Also, I'd suggest to rename all 'modes' to true state 
> > machine naming: STATE_INITIALIZED, STATE_SHUT_DOWN, 
> > STATE_PERIODIC, STATE_RESUMED, etc.: if these are enums 
> > for
> 
> I thought so initially and it looked like the diff will 
> be huge as all the variables for the enum, i.e. 'mode', 
> need to be renamed to 'state'..
> 
> But, if you are okay with it then I would be happy to do 
> that..

Well, how does the diffstat look like?

But if the conversion was scripted (i.e. is relatively 
secure from typos) then that's still fine IMO. Peter?

Thanks,

	Ingo
