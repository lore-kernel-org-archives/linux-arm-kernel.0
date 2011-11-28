From: hjk@hansjkoch.de (Hans J. Koch)
Date: Mon, 28 Nov 2011 11:45:55 +0100
Subject: Fwd: Re: [03: PATCH 0/5] The remaining stuff
In-Reply-To: <20111124204447.GW9581@n2100.arm.linux.org.uk>
References: <20111124204447.GW9581@n2100.arm.linux.org.uk>
Message-ID: <20111128104554.GA2165@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 08:44:47PM +0000, Russell King - ARM Linux wrote:
> Please reply to the forwarded message (which was posted to the mailing
> list.)
> 
> ----- Forwarded message from Russell King - ARM Linux <linux@arm.linux.org.uk> -----
> Date: Fri, 11 Nov 2011 17:16:50 +0000
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> To: linux-arm-kernel at lists.infradead.org
> Subject: Re: [03: PATCH 0/5] The remaining stuff
> 
> On Sun, Nov 06, 2011 at 05:54:57PM +0000, Russell King - ARM Linux wrote:
> > Part 3 - the remaining stuff
> > 
> > These are patches which I've managed to get half way through before
> > getting - to be honest - totally hacked off with the code found in
> > various platforms (as mentioned in previous mails).
> > 
> > These platforms are broken as a result of the final patch in part 2,
> > and these patches move these platforms _towards_ a solution.  They
> > are not a complete solution though, but the start of the solution.
> > 
> > For instance, the Exynos4 and S5PV210 patches both consist of almost
> > a full solution -but- with the new function prototype missing because
> > there is _no_ local header file to put it in, and I'm damned well not
> > putting it in the remote plat-samsung/include/plat headers.
> > 
> > The final set of platforms - touched neither by part 3 nor 4, are
> > broken by the final patch in part 2, and at present I have no plans
> > to fix them.  I would welcome patches to fix these which address the
> > issues raised in the "pet peaves" email (which is why I have no plans
> > to fix them.)
> 
> The list of platforms which are still broken (today) by part 2 of this
> series are:
> 
> arch/arm/mach-davinci/include/mach/system.h
> arch/arm/mach-gemini/include/mach/system.h
> arch/arm/mach-nomadik/include/mach/system.h
> arch/arm/mach-s3c2410/include/mach/system-reset.h
> arch/arm/mach-s3c64xx/include/mach/system.h
> arch/arm/mach-shmobile/include/mach/system.h
> arch/arm/mach-vt8500/include/mach/system.h
> arch/arm/plat-samsung/include/plat/system-reset.h
> arch/arm/plat-tcc/include/mach/system.h
> 
> which require assistance to get these into shape.
> 
> As I've already implied, I'm quite prepared to break these platforms at
> the next merge window for the greater good if there's no sign of
> maintainers willing to help sort them out - which will then ultimately
> result in them being deleted from mainline.

For the past 12 months, nobody was interested in Telechips (plat-tcc).
No community, no customers, no support from Telechips. Under these
circumstances, I am not willing to maintain this forever.

However, Harry Sievers, European distributor of Telechips, told me
that there are persons at Telechips who are interested in having
their stuff in mainline. He will tell them it is threatened with
being deleted from mainline, and ask for support.

I am willing to wait until christmas for any news from Harry, and
will then send a patch. Either one that fixes the arch as requested in
the mail above, or one that removes the whole platform from mainline.
My feeling is that the latter is more likely.

Russell, if that is too late for you, please let us know.

Thanks,
Hans
