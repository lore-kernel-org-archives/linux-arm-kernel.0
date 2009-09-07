From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 7 Sep 2009 13:39:45 +0200
Subject: zaurus c3000 aka spitz: fix resume
In-Reply-To: <1252243938.4136.26.camel@utx.utx.cz>
References: <20090906052840.GF1324@ucw.cz>
	<1252243938.4136.26.camel@utx.utx.cz>
Message-ID: <20090907113945.GN23450@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > sharpsl_pm.c code tries to read battery state very early during
> > resume, but those battery meters are connected on SPI and that's only
> > resumed way later.
> > 
> > Replace the check with simple checking of battery fatal signal, that
> > actually works at this stage.
> 
> Tested on:
> - SL-C3200
> - snapshot e07cccf4046978df10f2e13fe2b99b2f9b3a65db
> - Reverted: 15bce40cb3133bcc07d548013df97e4653d363c1 (manual merge)
> - Applied your patch.
> - Config is here:
>   http://www.penguin.cz/~utx/zaurus/feed/images/spitz/config-2.6.31-rc9-spitz
> 
> Here is a big progress:
> - Zaurus goes from resume.

Ouch, it seems Eric Miao's emails are currently bouncing :-(.
									Pavel
This is an automatically generated Delivery Status Notification.

Delivery to the following recipients failed.

       ymiao3 at marvell.com

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
