From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 May 2012 19:39:49 +0000
Subject: [PATCH] ixp4xx: fix compilation by adding gpiolib support
In-Reply-To: <87396qbtrx.fsf@lebrac.rtp-net.org>
References: <1337789991-5283-1-git-send-email-richardcochran@gmail.com>
 <201205231743.50262.arnd@arndb.de> <87396qbtrx.fsf@lebrac.rtp-net.org>
Message-ID: <201205231939.49681.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 May 2012, Arnaud Patard wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Wednesday 23 May 2012, Richard Cochran wrote:
> >> Once again, ixp4xx no longer even compiles. This patch fixes the issue
> >> by converting over to gpiolib. This patch was first made by Imre and
> >> posted by Marc, and I added in Russell's suggestion to empty the gpio
> >> header file.
> >> 
> >> This fix should also go for 3.1, 3.2, 3.3, and 3.4.
> >> 
> >> Signed-off-by: Richard Cochran <richardcochran@gmail.com>
> >> Cc: <stable@vger.kernel.org>
> >
> > So has every kernel since 3.1 been broken, or is it just broken now
> > but a good idea to backport anyway?
> 
> every kernel since 3.1 (even 3.1-rc-something). Would be nice to see
> this issue fixed as similar patches have been sent from time to time but
> never been merged.

Ok, thanks for the info. I'm sorry that it has come so far. I think Olof
and I are generally doing a good job at picking up all the pull requests,
but we sometimes miss single patches, especially when it's not clear that
they are expected to go into the arm-soc tree.

I have to admit that I didn't even remember who maintains ixp4xx, since
there hasn't been a single ixp4xx patch from Imre or Krzysztof that I've put
into the kernel over this time frame.

I've put the patch into the fixes branch now, it should be part of 
the next round of submissions.

What is the plan for ixp4xx going forward? Is one of you planning to
maintain a git tree and collect patches for inclusion in arm-soc?
I would be more comfortable just knowing where to pull from than
having to watch the mailing list and making sure the maintainers
Ack all the patches.
If there is no tree, should we downgrade ixp4xx in the MAINTAINERS
file from "Maintained" to "Odd fixes"?

	Arnd
