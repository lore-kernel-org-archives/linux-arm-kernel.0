From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 2 Mar 2010 12:48:09 +0800
Subject: [GIT PULL] pxa: patches for next merge window
In-Reply-To: <20100301151630.GA3002@n2100.arm.linux.org.uk>
References: <f17812d71002241849m6b37f601h7eef1a723b2d0335@mail.gmail.com>
	<20100225205113.GF3101@n2100.arm.linux.org.uk>
	<20100225212915.GA24043@n2100.arm.linux.org.uk>
	<f17812d71002260105q54c26198jc9b61851c35ae8ef@mail.gmail.com>
	<20100228161449.GD16745@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002281928200.10679@xanadu.home>
	<f17812d71003010523r6aa7cfd0va28b994dfadedeac@mail.gmail.com>
	<20100301151630.GA3002@n2100.arm.linux.org.uk>
Message-ID: <f17812d71003012048p2aabc731u141b6f9cf136cd34@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 1, 2010 at 11:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Mar 01, 2010 at 09:23:37PM +0800, Eric Miao wrote:
>> Russell,
>>
>> Regarding the problem of my rebased three commits that were already
>> merged into your tree, I'm seeing three ways out:
>>
>> 1. merge back your devel branch (tried and as you suggested is not a
>> very clean way)
>>
>> 2. merge linus v2.6.33-rc? and get the other commits rebased
>>
>> 3. rebase all the other commits against your devel branch or (devel-stable)
>>
>> Just lemme know which is the best approach.
>>
>> BTW, it would be very helpful to us if we are able to understand the
>> difference and how you maintain 'devel' and 'devel-stable' branch?
>
> The devel branch is unstable - it's a combination of topic branches,
> and these topic branches are regularly re-merged to produce a single
> head for Stephen Rothwell to pull into -next. ?The other reason for
> publishing it is to give Nicolas (and others) something to look at so
> they know what's going on in my tree.
>
> It also occasionally receives truely unstable patches for testing
> purposes, which very well could be dropped - eg, if they cause build
> errors. ?(Remember - I have no practical way to test patches which
> affect many ARM platforms, except by getting linux-next to pick them
> up.)
>
> What this means is that the commit IDs of the merges and occasionally
> patches will change, and as such, basing anything on top of it is a
> recipe for disaster.
>
> In theory, the devel-stable branch receives merges of external trees,
> occasionally receives local merges from stable topic branches, but is
> never rebased and no commits are ever undone on it.
>
> So, basing patches on top of devel-stable should be safe.
>
> If you can arrange for your tree to be rebased upon devel-stable, that
> should solve the problem, and avoid any need to mess around with what's
> already committed there.
>

OK, rebased and pushed. Let me know if there are any remaining issues
during re-pull as I don't want block others from being pulled, feeling
guilty... ;-P

- eric
