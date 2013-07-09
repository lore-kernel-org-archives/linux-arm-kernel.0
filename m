From: tony@atomide.com (Tony Lindgren)
Date: Tue, 9 Jul 2013 01:23:04 -0700
Subject: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
In-Reply-To: <20130708142103.GX21614@n2100.arm.linux.org.uk>
References: <20130517191304.468.73487.stgit@localhost>
 <20130517191751.468.89202.stgit@localhost>
 <20130520095447.GR21614@n2100.arm.linux.org.uk>
 <20130706131057.GU21614@n2100.arm.linux.org.uk>
 <20130706133627.GV21614@n2100.arm.linux.org.uk>
 <20130708093410.GT5523@atomide.com>
 <20130708142103.GX21614@n2100.arm.linux.org.uk>
Message-ID: <20130709082304.GB5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130708 07:27]:
> On Mon, Jul 08, 2013 at 02:34:11AM -0700, Tony Lindgren wrote:
> > 
> > Hey the good news is that you've updated your build system to support
> > also appended dtb images, thanks for doing that!
> 
> It was far from trivial - there's many places in the build process
> which do things quite differently depending on whether it's a DTB
> build or not.

Yes that's too bad. We can make it slightly easier to update from custom
.config files by always building in support for board-generic.c.
 
> It seems that - yet again - the mmc devices have swapped themselves.

Hmm they also seem to swap depending if there's a card plugged in.

> Also looks like the nonfunctional video stuff is even more nonfunctional
> than usual:
> 
> omapdss DSI error: can't get VDDS_DSI regulator
> omapdss HDMI error: can't get VDDA_HDMI_DAC regulator

Tomi?
 
> ASoC looks dead too:
> 
> omap-abe-twl6040 sound.10: ASoC: CPU DAI (null) not registered
> omap-abe-twl6040 sound.10: snd_soc_register_card() failed: -517

Peter, I think you've had audio working with devicetree for at least
a year or something?

Regards,

Tony
