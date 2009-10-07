From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 7 Oct 2009 10:58:06 +0200
Subject: spitz: add gpio button support (AK_INT and remote control
	description)
In-Reply-To: <1254829732.3546.35.camel@utx.utx.cz>
References: <20091006074635.GA2775@ucw.cz>
	<1254829732.3546.35.camel@utx.utx.cz>
Message-ID: <20091007085806.GB28807@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2009-10-06 13:48:52, Stanislav Brabec wrote:
> Pavel Machek wrote:
> > I'm not sure what AK_INT is, nor what event it should
> > generate.
> 
> AK_INT: remote control detect

Thanks. So for now I'll do:

        /* This is for remote control support. Zaurus supports wired                  
           remote on headphones. */
        {
                .type   = EV_KEY,
                .code   = KEY_F13,
                .gpio   = SPITZ_GPIO_AK_INT,
                .desc   = "Wired remote (AK_INT)",
        },

..and leave it for proper driver to support nicely.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
