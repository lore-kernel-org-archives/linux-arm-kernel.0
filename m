From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 27 Jul 2013 11:51:06 -0700 (PDT)
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have people
 interested in device tree janitoring / cleanup?]
In-Reply-To: <20130727183059.GD4813@netboy>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F39FD8.6080808@broadcom.com> <20130727183059.GD4813@netboy>
Message-ID: <1441731.8CGUI1tUxh@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 27 of July 2013 20:31:01 Richard Cochran wrote:
> On Sat, Jul 27, 2013 at 12:24:24PM +0200, Arend van Spriel wrote:
> > That is a nice summary of how we got from null to now and Richard
> > seems to be simply saying: let's stop mucking about and make this a
> > project with a well-defined process of dealing with staging and
> > stable bindings and keep stable bindings stable.
> 
> Yes, that is right.
> 
> Frankly, I am really surprised and shocked at the cavalier attitude
> expressed here WRT DT bindings in released kernels. Think about the
> *users* of this code. Not everyone working with ARM Linux is a kernel
> developer or a DT guru. There is really no indication at all that the
> ARM Linux DT stuff released so far are not stable and trustworthy.
> 
> It is not nice to provide such a mess, and the idea that we *must*
> have a mess because the whole system in still in development is bogus,
> IMHO. Just make sure that the mainline kernel is really working and
> that the DT bindings *there* are for keeps.
> 
> It is your job as kernel developers.

Well, it depends on how we use the DT. There are (at least) two possible 
usage scenarios:

 a) using DT as direct replacement for board files - this means that you 
    are free to say that DTSes are strictly coupled with kernel version 
    and you are free to modify the bindings - see the analogy to board 
    files, where you could modify the platform data structures and could 
    not directly copy board file from one kernel version to another,

 b) using DT as an ABI - this is the original way, i.e. define stable 
    bindings and make sure that anu DTB built for older kernel will work,
    with equal or greater set of functionality on newer kernels.

Now I believe in this thread the point whether we should use a) or b) or a 
combination of both has been raised.

As for current situation, from users' perspective it's almost no 
difference. With a) they can use appended DTB feature (or hack, whatever 
you prefer). With b) they just upload new zImage/uImage/whatever, leaving 
old DTB as is, if they don't want any new functionality. If there is 
support added for new functionality, they must update their DTBs anyway, 
so there is no clear advantage of b) over a) in this matter.

So, basically, this is not an obvious issue. Without analyzing (and 
discussing) possible use cases, issues, consequences and whatever, there 
is no obvious answer, such as "just stabilize whatever we have now!" or 
"go back to board files!".

We have what we have, it is not perfect, some things have been screwed up, 
but we can't just leave that behind and say "now we'll be doing everything 
correctly", we must fix that up. People don't do everything correctly from 
the start, this is what the whole staging vs stable topic is about.

Best regards,
Tomasz
