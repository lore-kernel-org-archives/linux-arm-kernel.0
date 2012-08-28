From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 28 Aug 2012 10:13:20 -0700
Subject: [PATCH v2 1/2] ARM: clk-imx35: Fix SSI clock registration
In-Reply-To: <CAOMZO5B2feJzbqEQgJm_gKDcZPSKuckXWj=s+b+5R39Tnv7-kw@mail.gmail.com>
References: <1345466362-2576-1-git-send-email-fabio.estevam@freescale.com>
 <20120822192723.GS7995@opensource.wolfsonmicro.com>
 <CAOMZO5B2feJzbqEQgJm_gKDcZPSKuckXWj=s+b+5R39Tnv7-kw@mail.gmail.com>
Message-ID: <20120828171320.GE4534@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 04:38:26PM -0300, Fabio Estevam wrote:
> On Wed, Aug 22, 2012 at 4:27 PM, Mark Brown

> > in that it stops boot hanging on the board, though it still doesn't make
> > AC'97 come out of reset happily.  That's probably some separate issue
> > (pinmux perhaps?) though.

> Yes, looks like a separate issue.

> Did imx_ssi_probe go successfully? What is the error log you are getting?

The controller probes but there's no perceptible activity on the pins
when we try to reset the CODEC so no register I/O.
