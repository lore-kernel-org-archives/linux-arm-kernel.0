From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 May 2013 10:08:49 +0100
Subject: [RFC PATCH 0/2] ARM: Remove any correlation between IPC and
 BogoMips value
In-Reply-To: <5187EFF3.6010005@codeaurora.org>
References: <1367602547-19322-1-git-send-email-will.deacon@arm.com>
 <5187EFF3.6010005@codeaurora.org>
Message-ID: <20130507090849.GC25387@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 06, 2013 at 07:01:23PM +0100, Christopher Covington wrote:
> Hi Will,
> 
> On 05/03/2013 01:35 PM, Will Deacon wrote:
> > Hi all,
> > 
> > This small patch set may look a little over a month late, but there is a
> > serious reason for posting it.
> > 
> > When I moved the ARM delay loop over to using the architected timers
> > rather than the CPU spinning loop (which has all the problems associated
> > with cpu frequency scaling and what-not) I thought I was doing something
> > useful for the port. However, it turns out that a surprising number of
> > people have complained, and continue to complain, about the drop in
> > their `BogoMIPs score'.
> 
> Have you considered adding the old code back in, but in a form that's not at
> all referenced by the delay loop code and just calculates CPU-based bogomips?

That seems like a lot of effort in order to preserve something that isn't
even meaningful. We might be better just zeroing the value, but then we'll
inevitably get bug reports of it being `wrong'.

Plus, the calibration during boot introduces a brief delay when onlining
each core whereas this can be skipped when using a constant timer.

Will
