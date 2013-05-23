From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 May 2013 14:09:19 +0200
Subject: [PATCH 1/3] ARM: at91: move at91 aic driver to drivers/irqchip
In-Reply-To: <20130523115845.GA24476@game.jcrosoft.org>
References: <1369299909-10078-1-git-send-email-b.brezillon@overkiz.com>
 <1369299909-10078-2-git-send-email-b.brezillon@overkiz.com>
 <20130523090611.GG9937@game.jcrosoft.org>
 <519DE6A8.6040502@overkiz.com> <20130523120920.1df8e23a@skate>
 <20130523100951.GH9937@game.jcrosoft.org>
 <20130523122000.22a9a4d0@skate>
 <20130523102601.GI9937@game.jcrosoft.org>
 <20130523132255.3acf4431@skate>
 <20130523115845.GA24476@game.jcrosoft.org>
Message-ID: <20130523140919.1b5800f2@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jean-Christophe PLAGNIOL-VILLARD,

On Thu, 23 May 2013 13:58:45 +0200, Jean-Christophe PLAGNIOL-VILLARD
wrote:

> > Or, alternatively, we can make the irqchip driver show using
> > pr_debug() the value of IMR in its ->suspend() hook, the value of IMR &
> > IPR in its ->resume() hook, and the pm.c code can show the PMC_PCSR on
> > suspend. This way, you have all the informations you need for debugging.
> 
> if you read the code as you said both of them are link PMC & AIC so you can
> not hope to split it as both of the IP contain part of the information
> 
> so no I want the information right where it's

Sorry, but that seems like a completely unreasonable requirement,
provided that it makes the PM code poke into a completely unrelated IP,
just for the sake of one debug message.

> > Having the PM driver and the irqchip driver step on each other register
> > areas is anyway a bad idea, especially when the only reason to do so is
> > for two debugging messages that can be implemented differently.
> 
> > 
> > Notice that this solution can always be improved later on if needed,
> > with further cleanups from you.
> > 
> > But please stop rejecting valid patches from contributors, just because
> > the code is not coming from you. What Boris is proposing is perfectly
> so If I read you non clean code can come mainline, wow this not the way to
> work. If for you do half clean is enough to go mainline. You really need to
> change your way of working.

Boris patches are far from being half-clean. To me, they look perfectly
sane, and are going in the right direction. Again, please stop
rejecting contributions from third-parties just because you're not the
author of such contributions.

It's you who said that they are not clean, but you still haven't given
the slightest explanation to justify that. Until a proper justification
is given, that points to specific, identifiable, and reasonable
problems in the patches, there is absolutely no reason not to consider
Boris patches as acceptable (once the header problem is fixed, of
course).

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
