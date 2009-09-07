From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 8 Sep 2009 00:32:08 +0200
Subject: zaurus c3000 aka spitz: fix resume
In-Reply-To: <f17812d70909070908l26541562iec36a117c155aa08@mail.gmail.com>
References: <20090906052840.GF1324@ucw.cz>
	<1252243938.4136.26.camel@utx.utx.cz>
	<f17812d70909070908l26541562iec36a117c155aa08@mail.gmail.com>
Message-ID: <20090907223208.GC695@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2009-09-08 00:08:13, Eric Miao wrote:
> On Sun, Sep 6, 2009 at 9:32 PM, Stanislav Brabec<utx@penguin.cz> wrote:
> > Pavel Machek wrote:
> >> sharpsl_pm.c code tries to read battery state very early during
> >> resume, but those battery meters are connected on SPI and that's only
> >> resumed way later.
> >>
> >> Replace the check with simple checking of battery fatal signal, that
> >> actually works at this stage.
> >
> > Tested on:
> 
> Applied to 'fix'.

Thanks. Is there still chance to push it to 2.6.31? That would help a
lot. Alternatively, we could push it to the -stable tree at least...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
