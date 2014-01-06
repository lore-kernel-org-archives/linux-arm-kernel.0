From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jan 2014 11:14:28 +0000
Subject: [PATCH] ARM: imx: Explicitly pass the active level of the PHY
 reset
In-Reply-To: <20140106022419.GA26128@S2101-09.ap.freescale.net>
References: <1388750156-23208-1-git-send-email-festevam@gmail.com>
 <20140103120712.GE25079@S2101-09.ap.freescale.net>
 <20140104054702.GA6243@quad.lixom.net>
 <CAOesGMhDUZ6WVCoh50nNYZt+WMQvaWupHLHdjBz68kUaoPxnjQ@mail.gmail.com>
 <20140106022419.GA26128@S2101-09.ap.freescale.net>
Message-ID: <20140106111428.GF27432@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 10:24:23AM +0800, Shawn Guo wrote:
> This is a typical example that we did not implement device tree
> bindings perfectly right in the first place, and we have to live with it
> forever.  If someday there is board design using an active high PHY
> reset, we basically have to introduce another property for it.

Yes and no.  That third number in the property is always zero at present,
right?  If so, just define zero to mean "the default level of reset"
which would be the -rc6 behaviour.

Then you can define non-zero values to mean "explicitly state the level".

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
