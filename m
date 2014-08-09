From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 9 Aug 2014 17:21:49 +0200
Subject: [PATCH 2/6] ARM: mvebu: Add proper pin muxing on Globalscale
 Mirabox board
In-Reply-To: <20140808192106.GD26751@lunn.ch>
References: <1407511136-26477-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1407511136-26477-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140808171208.GC26751@lunn.ch>
 <20140808182156.GA16889@arch.cereza>
 <20140808192106.GD26751@lunn.ch>
Message-ID: <20140809172149.59f54746@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Fri, 8 Aug 2014 21:21:06 +0200, Andrew Lunn wrote:

> At least at the moment, it seems like RGMII is the norm, and SGMII is
> the exception. So having the default as RGMII probably makes
> sense. Boards which don't require it can then override this in there
> .dts file. If we see this changes with time, we can swap it around.

I personally disagree with this approach. armada-370.dtsi is here to
describe what happens at the *SoC* level, not to factorize some random
board specific details that appear to be common between a certain
number of boards (but not all).

So I really, really, would prefer to keep the board-specific details
such as which pin muxing is done for Ethernet in each individual .dts
file.

.dtsi to describe the SoC, .dts to describe the board. It's clear and
simple for everyone to understand, especially for new comers.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
