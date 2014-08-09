From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 9 Aug 2014 12:52:37 -0300
Subject: [PATCH 2/6] ARM: mvebu: Add proper pin muxing on Globalscale
 Mirabox board
In-Reply-To: <20140809172149.59f54746@free-electrons.com>
References: <1407511136-26477-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1407511136-26477-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140808171208.GC26751@lunn.ch>
 <20140808182156.GA16889@arch.cereza>
 <20140808192106.GD26751@lunn.ch>
 <20140809172149.59f54746@free-electrons.com>
Message-ID: <20140809155237.GA602@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09 Aug 05:21 PM, Thomas Petazzoni wrote:
> On Fri, 8 Aug 2014 21:21:06 +0200, Andrew Lunn wrote:
> 
> > At least at the moment, it seems like RGMII is the norm, and SGMII is
> > the exception. So having the default as RGMII probably makes
> > sense. Boards which don't require it can then override this in there
> > .dts file. If we see this changes with time, we can swap it around.
> 
> I personally disagree with this approach. armada-370.dtsi is here to
> describe what happens at the *SoC* level, not to factorize some random
> board specific details that appear to be common between a certain
> number of boards (but not all).
> 
> So I really, really, would prefer to keep the board-specific details
> such as which pin muxing is done for Ethernet in each individual .dts
> file.
> 
> .dtsi to describe the SoC, .dts to describe the board. It's clear and
> simple for everyone to understand, especially for new comers.
> 

Just to clarify, you say we should even have pin mux configuration in each dts,
or the configuration in the dtsi and the pin muxing of each device
in the dts?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
