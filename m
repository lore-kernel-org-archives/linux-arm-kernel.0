From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 24 Oct 2013 12:27:29 -0400 (EDT)
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <af289ef3cc80be8de26274ba1f598d54.squirrel@twosheds.infradead.org>
References: <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef> <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy> <20131023172955.GA17145@obsidianresearch.com>
 <20131023174458.GC5208@netboy>
 <1382553982.31058.10.camel@sakura.staff.proxad.net>
 <20131024095232.27BBCC4039D@trevor.secretlab.ca>
 <1382614439.6040.16.camel@sakura.staff.proxad.net>
 <1382615278.8522.72.camel@shinybook.infradead.org>
 <20131024122346.GD11296@ulmo.nvidia.com>
 <1382619655.6040.52.camel@sakura.staff.proxad.net>
 <516bfc7f9366ff3ef9187c36dd160888.squirrel@twosheds.infradead.org>
 <1382621431.6040.66.camel@sakura.staff.proxad.net>
 <af289ef3cc80be8de26274ba1f598d54.squirrel@twosheds.infradead.org>
Message-ID: <alpine.LFD.2.03.1310241146210.1951@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Oct 2013, David Woodhouse wrote:

> 
> >
> > On Thu, 2013-10-24 at 13:10 +0000, David Woodhouse wrote:
> >
> >> Note that you are not describing a normal "DT scenario" here. You are
> >> describing a case in which we screwed up
> >
> > AKA "real world"
> 
> No. Absolutely not. That was a screwup, and it needs to be *rare*. The
> excuses you present for it are crappy and uunacceptable.

Let's get real please.  It is just too easy for DT reviewers in their 
ivory tower to shot down submissions because the bindings are not to 
their liking.

The world out there is not stable.  Things change.  Hardware is revised 
all the time.  Software change to cope.  And even when the hardware is 
stable, new software solutions come about to improve things.  That's the 
point of _soft_ware, isn't it?  Flexibility is needed in order to scale.

"DT only describe the hardware" is often brought up as if that was the 
ultimate argument for its "stability".  But descriptions, even hardware 
descriptions, may be subjective i.e. two humans might describe it 
differently.  Incidentally DT bindings are created by humans and are 
therefore imperfect and suboptimal most of the time.

We used to have very lenient reviews on new DT bindings.  Sure some of 
them were bad.  The recent reaction to that was to go 180 degrees and 
accept only near perfect bindings.  But the cure is now hurting more 
than the initial problem.

Sure, the world would be so much better if DT bindings could be optimal 
on the first shot.  But asking that DT bindings remain stable when the 
world around them is not is asking for the impossible.

So IMHO the failure with DT right now is actually the expectations that 
come with it.  Those expectations are not realistic.

Special cases are the norm, whether you like it or not.  In fact we all 
hate special cases because they make what would otherwise be a very 
straight forward and elegant process rather messy.  This is why a 
process needs to concern itself with special cases since this is where a 
process is even more helpful.

So instead of trying to enforce even more stability in the DT bindings 
with stricter rules, I think that the process should instead concern 
itself with better ways to _allow_ and _facilitate_ binding updates.  
This is much more likely to scale, and result in a better system in the 
end.

And since there is so many changes one can bring to ultimately describe 
some piece of hardware, the DT bindings will naturally reach a stable 
state eventually. But that cannot be known in advance when that will be.


Nicolas
