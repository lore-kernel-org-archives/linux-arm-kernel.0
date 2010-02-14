From: mike@compulab.co.il (mike at compulab.co.il)
Date: Sun, 14 Feb 2010 11:01:43 +0200
Subject: smsc911x suspend/resume
In-Reply-To: <OFB9598254.A94CFB16-ON802576C5.004BB8B6-802576C7.00655296@smsc.com>
References: <20100208144951.GF28972@buzzloop.caiaq.de>
	<OFB9598254.A94CFB16-ON802576C5.004BB8B6-802576C7.00655296@smsc.com>
Message-ID: <20100214090143.GA23498@gentoodev.compulab.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2010 at 06:26:32PM +0000, Steve.Glendinning at smsc.com wrote:
> > Hmm, be careful about switching off power supplies that aren't supposed
> > to be switched off while others are still powered. You can easily
> > destroy hardware with that. Depending on how things are wired up
> > internally, voltages can leak from one unit block to the other. Maybe
> > Steve can can give a statement from official SMSC source about whether
> > it is safe to switch off VDD33A in this case.
> 
> I've checked with the chip architects, no power planes should be 
> externally
> switched off in any suspend mode.

The question if they *can* be switched off. With the hardware I have,
most of 3.3V supplies are enabled/disabled with the same control. So, to
have maximal power saving in the system, I just pull this control to
disable 3.3V supplies, VDD33A among them. If smsc9220 can tolerate
switching VDD33A during suspend, I can send a patch that allows proper
wake-up with such conditions.

> Steve
