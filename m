From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 16 Feb 2016 17:43:24 +0100
Subject: [PATCH] sound: hdmi: avoid dereferencing uninitialized 'jack'
 pointer
In-Reply-To: <20160216163840.GA7544@sirena.org.uk>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <s5hbn7g7izt.wl-tiwai@suse.de> <2573932.AU4HSxN0NE@wuerfel>
 <s5h4md87hnu.wl-tiwai@suse.de>
 <20160216163840.GA7544@sirena.org.uk>
Message-ID: <s5hy4ak61xv.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Feb 2016 17:38:40 +0100,
Mark Brown wrote:
> 
> On Tue, Feb 16, 2016 at 05:18:29PM +0100, Takashi Iwai wrote:
> > Arnd Bergmann wrote:
> 
> > > Another option might would be to change snd_jack_new() to return
> > > an error if that SND_JACK is disabled, and then require all users
> > > to handle the error gracefully, i.e. not fail the probe() function
> > > but just not use the jack.
> 
> > Yes, I thought of that, too.  If select is no good option, it's a good
> > alternative, indeed.
> 
> It's going to be a bunch of work to implement though.

Is it?  Which driver would be broken?  Many ASoC drivers just ignore
the return error completely.  Some treats as a fatal error, and the
behavior would change, yes.  But I don't think that such a driver
would work without CONFIG_SND_JACK properly in anyway.


Takashi
