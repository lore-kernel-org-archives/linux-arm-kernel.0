From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Feb 2016 16:38:40 +0000
Subject: [PATCH] sound: hdmi: avoid dereferencing uninitialized 'jack'
 pointer
In-Reply-To: <s5h4md87hnu.wl-tiwai@suse.de>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <s5hbn7g7izt.wl-tiwai@suse.de> <2573932.AU4HSxN0NE@wuerfel>
 <s5h4md87hnu.wl-tiwai@suse.de>
Message-ID: <20160216163840.GA7544@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 05:18:29PM +0100, Takashi Iwai wrote:
> Arnd Bergmann wrote:

> > Another option might would be to change snd_jack_new() to return
> > an error if that SND_JACK is disabled, and then require all users
> > to handle the error gracefully, i.e. not fail the probe() function
> > but just not use the jack.

> Yes, I thought of that, too.  If select is no good option, it's a good
> alternative, indeed.

It's going to be a bunch of work to implement though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160216/4932162c/attachment.sig>
