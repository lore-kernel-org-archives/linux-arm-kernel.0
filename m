From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 28 Oct 2012 21:59:56 +0100
Subject: [PATCH] ARM: kirkwood: Increase NAND chip-delay for DNS-320
In-Reply-To: <1351457262-11506-1-git-send-email-jm@lentin.co.uk>
References: <1351457262-11506-1-git-send-email-jm@lentin.co.uk>
Message-ID: <20121028205956.GH15143@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 28, 2012 at 08:47:42PM +0000, Jamie Lentin wrote:
> The default chip-delay of 25ns is a bit too tight for some DNS-320's,
> increase to 35ns.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
> I now own 2 DNS-320's, the first of which is happy with a mainline
> kernel, the second fills the console with "Bad eraseblock xxx at
> 0x00000xxxxxxx" for every eraseblock and refuses to access the NAND.
> Beyond this they appear identical, and report the same NAND chip
> (I haven't physically checked that it's the same, however).
> 
> The patch below fixes it, however:-
> * Is there something else I should be trying, rather than potentially
> masking the problem?
> * Is chip-delay too low for kirkwood generally?

Do you know what NAND chip it is? We can check the datasheet and see
what is specified.

All kirkwood's use 25ns and i don't think there have been any problems
reported. But that does not mean Dlink have mounted a slower device.

	  Andrew
