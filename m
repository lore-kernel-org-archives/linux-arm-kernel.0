From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 23 Oct 2013 14:13:12 -0700
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <20131023195849.GA8828@mithrandir>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <5267FA58.9050002@wwwdotorg.org> <20131023172001.GA3379@katana>
 <20131023185909.GC7863@ulmo.nvidia.com>
 <20131023193450.GE32563@obsidianresearch.com>
 <20131023195849.GA8828@mithrandir>
Message-ID: <CALCETrV66SUsv7pFr8+W9roy47WP3G1qbdxkuKkb8a4ExSHH0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 12:58 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Wed, Oct 23, 2013 at 01:34:50PM -0600, Jason Gunthorpe wrote:
>> On Wed, Oct 23, 2013 at 08:59:10PM +0200, Thierry Reding wrote:
>>
>> > > I'd say yes. Going from unstable to stable is quite a step for a binding
>> > > and that should be visible and worth a patch IMO. Also, when looking at
>> > > a DTS file or some driver code, it will avoid
>> > > confusion/misinterpretation if one can see immediately the status of a
>> > > binding.
>> >
>> > Yes, I fully agree. It might look like churn, but I think this could
>> > actually be a part of the formal process to stabilize a binding. It
>> > would be final step of that process, actually.
>>
>> I actually think this makes things worse.
>>
>> Ostensibly the purpose of stable DT is to allow the DT and kernel to
>> be separate, so you should minimize the churn in the DTs, and they
>> should trend to stable.
>
> Well, I do think that stable DT has benefits. And quite frankly I think
> the majority of bindings will eventually converge to some stable state
> anyway, if only because active development stops. In an ideal world that
> would be when a product ships.
>
> So this proposal isn't so much about making a decision for stable or
> experimental DT, but rather about giving users a choice. If they are
> willing to live with the additional "burden" of updating the DTB every
> once in a while, then they can enable the option and get additional
> functionality. If they don't want any part of that, they can just leave
> the option disabled and only get the parts that are stable.
>
>> Having a flag day where someone goes and churns the DT to remove a !,
>> and then changes the kernel so all old DTs with a ! won't work at all
>> makes this whole thing seem kinda contrary to the basic motivating
>> premis.
>
> No. Matching doesn't include the ! marker. So if you remove it from DTS
> files and/or drivers, the only thing that goes away is the warning at
> runtime. Feature-wise there should be no difference.
>
>> Also, what happens during development? If you incompatibly change the
>> binding you should change the name, so maybe <version>!marvell,foo is
>> the way to go.
>>
>> v1 of the binding is 1!marvell,foo - version 2 is 2!marvell,foo, etc.
>>

[I'm a random bystander -- I don't really know anything about DT.]

This sounds awfully like the -moz, -webkit, etc. CSS property
selectors.  They are AFAICT nearly universally considered to have been
a mistake.

--Andy
