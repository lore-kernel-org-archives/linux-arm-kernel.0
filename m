From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 19 Dec 2011 22:37:41 +0100
Subject: [PATCH] MXS: Convert mutexes in clock.c to spinlocks
In-Reply-To: <20111219212847.GK14542@n2100.arm.linux.org.uk>
References: <1324217174-6574-1-git-send-email-marek.vasut@gmail.com>
 <201112192205.25806.marek.vasut@gmail.com>
 <20111219212847.GK14542@n2100.arm.linux.org.uk>
Message-ID: <201112192237.42034.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, Dec 19, 2011 at 10:05:25PM +0100, Marek Vasut wrote:
> > > On Mon, Dec 19, 2011 at 09:54:25PM +0100, Marek Vasut wrote:
> > > > > So, in summary, you have everything you require to fix it outside
> > > > > the driver.  You just have to decide which of the two options you
> > > > > want to proceed with, and actually (and finally) do it instead of
> > > > > endlessly procrastinating and waiting for more and more bug
> > > > > reports (which is exactly what has happened so far.)
> > > > 
> > > > What the hell, I just recently found this bug and I submitted a patch
> > > > right away! What are you complaining about?!
> > > 
> > > If you want to take that attitude to my attempt to help you understand
> > > the problem and see solutions, I'll ignore you permanently for being an
> > > absolute twit.
> > 
> > Go ahead, but you accused me of procrastinating and waiting even if the
> > first thing I did when I saw the bug was start solving it. That's just
> > insane!
> > 
> > > I'm not going to spend time giving a detailed explaination
> > > about the background and options over something to only then have it
> > > immediately shoved back in my face with such a response.
> > 
> > I consider my response to the last part of your email appropriate.
> 
> Sorry, it wasn't directed personally at you, but to the entire MXS
> community.  The facts over this are:

Ah! I'm sorry I was so direct and rude too. I was unaware it was discussed 
before, I started this effort on my own just recently.

> 
> 1. This problem has been known about since October.

I was really away from the kernel community for a while so I didn't know.

> 2. It's been discussed several times - every time along the same lines.
> 3. There is zero apparant progress on the issue.
> 
> Here's two of the discussions over it, where I've said exactly the same
> thing:
> 
> http://lists.arm.linux.org.uk/lurker/thread/20111018.173744.46c4bd76.en.htm
> l
> http://lists.arm.linux.org.uk/lurker/thread/20111123.183640.222b05cf.en.ht
> ml
> 
> So now, tell me - is this _finally_ going to get fixed in the MXS code,
> or is the previous discussion about converting stuff to spinlocks etc
> just going to be repeated yet again?

Spinlocks are OK as far as the code within them is fast, right ? But hm ... 
actually, we might be able to toggle the clock in one instruction by using the 
bitwise set/clear registers. That way, we won't need the locks at all, but we'd 
loose the usecount ... which is useless anyway).

M
