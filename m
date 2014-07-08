From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Jul 2014 07:57:27 -0400
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.17
In-Reply-To: <20140708053434.GH28931@quad.lixom.net>
References: <20140627130129.GH23978@titan.lakedaemon.net>
 <20140708053434.GH28931@quad.lixom.net>
Message-ID: <20140708115727.GR23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 07, 2014 at 10:34:34PM -0700, Olof Johansson wrote:
> On Fri, Jun 27, 2014 at 09:01:29AM -0400, Jason Cooper wrote:
> > Guys,
> > 
> > It's a pretty slow cycle this time around, so here's what I have so far.
> > Nothing controversial, just putting the last nail in the coffin for
> > mach-kirkwood/ . :-)
> > 
> > Please pull.
> 
> FWIW, holding off until the CuBox issue has been resolved -- I didn't see
> a resolution in the thread.

?  Sebastian is working on a follow-on patch to add a comment to the dts
file regarding the CuBox's lack of programmatic determinism.
Unfortunately there's nothing else we can do.

The patches Sebastian has written are correct in that *most* CuBox
owners have production models.  So if those users select dove-cubox.dtb,
they'll get a working system.  On the off chance they don't know they
have an engineering sample, card-detect won't work.

All CuBoxes bootloaders are non-DT, so users will be appending the dtb.
Which presents a very manageable upgrade path.  Just not ideal.  And
asking the user to swap out dtbs if the card-detect doesn't work isn't
ideal either.  Unfortunately, SolidRun left us with no clean way to
detect which board we are running on.

Can you offer any suggestions as to how you would like this resolved?  I
thought when I voiced my opinion as above, and Russell didn't reply,
there was implied acknowledgement...

I can drop the cubox changes if you want, but I'm struggling to see a
technical reason to do so.

thx,

Jason.
