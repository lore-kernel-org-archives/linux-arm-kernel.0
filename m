From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 10 Aug 2014 19:38:26 +0200
Subject: [PATCH 2/6] ARM: mvebu: Add proper pin muxing on Globalscale
 Mirabox board
In-Reply-To: <20140809155756.GB5427@titan.lakedaemon.net>
References: <1407511136-26477-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1407511136-26477-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140808171208.GC26751@lunn.ch>
 <20140808182156.GA16889@arch.cereza>
 <20140808192106.GD26751@lunn.ch>
 <20140809172149.59f54746@free-electrons.com>
 <20140809155756.GB5427@titan.lakedaemon.net>
Message-ID: <20140810193826.6c4c02c4@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Sat, 9 Aug 2014 11:57:56 -0400, Jason Cooper wrote:

> > I personally disagree with this approach. armada-370.dtsi is here to
> > describe what happens at the *SoC* level, not to factorize some random
> > board specific details that appear to be common between a certain
> > number of boards (but not all).
> 
> It's my understanding that *possible* pinmux configurations are a
> characteristic of the SoC.  Which configurations are used is an artifact
> of the board.
> 
> I don't see the need to list all possible configurations in the SoC dtsi
> file, but just the ones we have actually seen used.

Absolutely.

> > So I really, really, would prefer to keep the board-specific details
> > such as which pin muxing is done for Ethernet in each individual .dts
> > file.
> 
> So, wouldn't this be the phandle selection?

Yes.

> > .dtsi to describe the SoC, .dts to describe the board. It's clear and
> > simple for everyone to understand, especially for new comers.
> 
> If you're strongly opposed to describing possible pinmux configurations
> in the SoC dtsi file, how about an SoC-pinmux.dtsi?  I just see the
> "Thar be dragons ahead" sign by describing pinmux in the board files.

Not at all. Pinmux configurations in the .dtsi files are perfect, as
long as those pinmux configurations are related to "SoC" things, which
the RGMII pinmux configurations are.

However, Andrew was suggesting to move the phandle selection to
the .dtsi file, with the argument that most boards use RGMII, so it
should be the default. That's what I disagreed with.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
