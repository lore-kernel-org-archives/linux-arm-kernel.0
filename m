From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 9 Dec 2013 12:46:07 -0800
Subject: [PATCH] mtd: nand: pxa3xx: Disable "armada370-nand" compatible
 support
In-Reply-To: <20131208014049.GJ11251@titan.lakedaemon.net>
References: <1386430787-2962-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131207232315.GC11251@titan.lakedaemon.net>
 <20131208013525.GA4487@localhost>
 <20131208014049.GJ11251@titan.lakedaemon.net>
Message-ID: <20131209204607.GV27149@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On Sat, Dec 07, 2013 at 08:40:49PM -0500, Jason Cooper wrote:
> On Sat, Dec 07, 2013 at 10:35:26PM -0300, Ezequiel Garcia wrote:
> > If we agree to remove the lines, shall we also revert the binding
> > documentation, removing the compatible from there as well?
> 
> I think this is unnecessary.  We're trying to prevent breaking
> bisection.  No one in their right mind should be developing (and
> referring to docs) at a random commit.  As long as the docs are correct,
> leave them alone.

I agree, we don't need to drop all the docs, just the lines with the
'compatible' property. And #if 0 is a no-go; let's just delete the
lines.

Yes, the docs will appear in 3.12 and 3.13 even though the driver
support won't be there until 3.14, but that's OK IMO.

Do you think this should go to 3.12.y stable? If so, please add the
appropriate Cc tag. BTW, you moved these lines around in 3.13 so far,
so the patch probably won't apply 100% clean.

Can you refresh this patch according to Jason's comments and resend?

Brian
