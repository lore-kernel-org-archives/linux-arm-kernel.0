From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Aug 2014 19:14:06 +0100
Subject: [PATCH 3/6] arm64: Add support for hooks to handle undefined
 instructions
In-Reply-To: <9hhy4ube1tz.fsf@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
 <1409048930-21598-4-git-send-email-punit.agrawal@arm.com>
 <20140826131339.GO23445@arm.com> <9hhy4ube1tz.fsf@arm.com>
Message-ID: <20140826181405.GG23445@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 03:56:56PM +0100, Punit Agrawal wrote:
> Will Deacon <will.deacon@arm.com> writes:
> > On Tue, Aug 26, 2014 at 11:28:47AM +0100, Punit Agrawal wrote:
> >>  asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
> >>  {
> >>  	siginfo_t info;
> >> @@ -266,6 +329,9 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
> >>  	if (!aarch32_break_handler(regs))
> >>  		return;
> >>  
> >> +	if (call_undef_hook(regs) == 0)
> >> +		return;
> >
> > I'd like to reuse this hook for the aarch32 break hooks (you can see the
> > direct call in the context above). That means adding support for thumb
> > after all. Is there a reason you've been avoiding that?
> 
> None, other than to not add code before it's needed. I've just had a
> quick look at break handler and it looks pretty straight forward to fold
> that change in this set. Are you OK with that?

Just do it as a separate patch on top of this one.

Will
