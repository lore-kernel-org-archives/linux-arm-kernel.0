From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 18 Apr 2012 15:24:45 +0200
Subject: [PATCH V5 0/4] ARM: Kirkwood: Add support for DNS-320 and
 DNS-325 using devicetree
In-Reply-To: <20120418131635.GK15711@titan.lakedaemon.net>
References: <1334743603-8488-1-git-send-email-jm@lentin.co.uk>
 <20120418131635.GK15711@titan.lakedaemon.net>
Message-ID: <20120418132445.GB25584@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > dies at "Gating clock of unused units", presumably as CGC_RUNIT isn't set.
> > Is this something known or is it worth further investigation?
> 
> That could potentially mess up a future bisect.  However, it would only
> crop up for dnskw boards.  I'll let Grant weigh in on this since he's
> the one who asked that the nand init be removed.

Turning off RUNIT is bad. Both the NAND and SPI controllers use this
clock. You can only safely turn it off if none of these are active.

       Andrew
