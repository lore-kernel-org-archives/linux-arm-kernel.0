From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Feb 2011 13:13:08 +0000
Subject: [RFC,PATCH 1/3] Add a common struct clk
In-Reply-To: <20110210130800.GB3316@richard-laptop>
References: <1297233693.242364.862698430999.1.gpush@pororo>
	<4D52F73A.4010707@bluewatersys.com>
	<20110210100319.GB24710@b20223-02.ap.freescale.net>
	<20110210104639.GZ27982@pengutronix.de>
	<20110210130800.GB3316@richard-laptop>
Message-ID: <20110210131308.GB1742@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 10, 2011 at 09:08:00PM +0800, Richard Zhao wrote:
> Why? what restriction will it cause to add parent in clk?
> Two benifits at least I can see:
> 1. null ops handle, as I said above.
> 2. export clock tree to user level for debug. It's very helpfull.

Don't be tempted to expand what's done at the generic level.  Platforms
may need special handling at the current clock level before the parent
clock level is considered.  Also platforms may not have parents so it
becomes mere bloat.

The more complicated the generic level becomes, the more platforms won't
covert to it.
