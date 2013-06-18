From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 18 Jun 2013 18:06:29 -0400 (EDT)
Subject: [PATCH 1/2] ARM: vexpress/TC2: basic PM support
In-Reply-To: <CAOesGMiE4uRM01obQA584Neufws5K8HsarA0TVcx-2JmSdNgGQ@mail.gmail.com>
References: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
 <1370587152-4630-2-git-send-email-nicolas.pitre@linaro.org>
 <20130613203218.GA22310@quad.lixom.net>
 <alpine.LFD.2.03.1306131817310.18597@syhkavp.arg>
 <20130618172434.GI3289@localhost.localdomain>
 <alpine.LFD.2.03.1306181528050.18597@syhkavp.arg>
 <CAOesGMiE4uRM01obQA584Neufws5K8HsarA0TVcx-2JmSdNgGQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1306181722530.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Jun 2013, Olof Johansson wrote:

> I agree with most of the thread so far, but just wanted to highlight this:
> 
> On Tue, Jun 18, 2013 at 12:50 PM, Nicolas Pitre
> <nicolas.pitre@linaro.org> wrote:
> 
> > Well... right now I think it is hard to abstract things properly as we
> > have very few backends.  I would like to see more of them first.
> 
> Yes. This.
> 
> And this is why it's critical, absolutely critical, that the first one
> or two implementations go in are as simple and clean as possible.

I'll claim that this is rather utopic.  Simply because, once again, we 
don't know how to do so yet.  This is an iterative process and things 
will converge eventually.  But right now, even if the code is not 
necessarily as simple and clean as possible, it is certainly good enough 
for a start.

The perfect is the worst enemy of the good enough.

> Otherwise seeing the commonalities and how to abstract them out will
> be a complete headache, since only the person writing the driver will
> be able to get a good grasp of it (alternatively, it will take a lot
> of effort for someone to figure out, clean up, and see the bigger
> picture).

I don't see things as dramatically.  Probably because I'm one of the 
people who worked directly on this stuff.  And I don't intend to 
disappear after the code hits mainline either.  I therefore don't expect 
things to get out of control.  The job doesn't end there.

We do have ideas about improving things and the discussion is happening.  
But it would be wrong to wait until we can't think of any way to improve 
the code any further before merging it.  Otherwise even btrfs would 
still be out of tree.

The danger right now is that other people will reinvent their own layer 
because they have no model to follow at all.  That is even worse than 
having an imperfect model IMHO.

What we need is more exposure of this code.  It needs to be used and 
fiddled with by more people.  It has lived out of tree for a year 
already, and it would be about time its evolution happens in mainline 
from now on.

Let's also not forget that, right now, TC2 is the only fully functional 
big.LITTLE hardware implementation available to people.  Having it 
supported in mainline, even if not optimally at first, would greatly 
help other issues such as scheduler improvements for hybrid 
multiprocessing which are far more important than this code, as such 
platform could be distributed to scheduler people who might not always 
be bothered by low-level PM details and out-of-tree patches.

Please, understand that I fully appreciate the level of review and 
scrutiny that you provide and you do a very good job at it. However some 
accommodations for a compromise would be appreciated for the greater 
good here.


Nicolas
