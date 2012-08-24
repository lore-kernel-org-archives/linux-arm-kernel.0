From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 24 Aug 2012 13:12:11 +0200
Subject: [RFC][PATCH] Disintegrate sharpsl_param.c
In-Reply-To: <1345663182.3907.134.camel@ted>
References: <1345656424-31234-1-git-send-email-dromede@gmail.com>
 <1345663182.3907.134.camel@ted>
Message-ID: <20120824111211.GA28183@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > From: Marko Katic <dromede.gmail.com>
> >
> > I recently tried running 3.6-rc2 kernel on my Sharp Zaurus C-1000. It 
> > hanged almost immediately after uncompressing the kernel. I tracked the
> > problem down to a single line in arch/arm/common/sharpsl_param.c:
> > 
> > memcpy(&sharpsl_param, (void *)PARAM_BASE, sizeof(struct sharpsl_param_info));
> > 
> > Commenting out the line makes the kernel boot just fine. This left me
> > wondering whether sharpsl_param.c is actually needed. Here's a comment
> > from sharpsl_param.c that describes what sharpsl_param.c actually does:
> 
> Sharp went to the trouble of saving these values into the hardware and
> passing them into the drivers. They're basically used by the LCD
> initialisation code from what I remember. I don't remember what the
> risks are of incorrect values.

We were seeing strange flicker on LCD on some machines...? Particulary
metan's machine with wifi on did that. OTOH it looked like some kind
of DMA issue.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
