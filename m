From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 18 Dec 2012 08:04:20 +0100
Subject: [PATCH 4/4] FEC: Add time stamping code and a PTP hardware clock
In-Reply-To: <20121217200232.GS26326@pengutronix.de>
References: <1351657531-25989-1-git-send-email-Frank.Li@freescale.com>
 <20121217091345.GA753@pengutronix.de>
 <CAHrpEqTVuSR_-Tpdzb98=VJbg7grSFvSQ9xA6mPsHpGb7RvNCg@mail.gmail.com>
 <20121217151445.GA17907@S2101-09.ap.freescale.net>
 <20121217200232.GS26326@pengutronix.de>
Message-ID: <20121218070420.GA2946@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 17, 2012 at 09:02:32PM +0100, Sascha Hauer wrote:
> This leaves an option in the tree which can be used to break FEC on
> i.MX3/5.
> 
> 	depends on !SOC_IMX31 && !SOC_IMX35 && !SOC_IMX5
> 
> might be an option, but given that this patch seems to have bypassed any
> review I feel more like reverting it.

Instead of reverting, I suggest finding a solution (Frank) to let the
code work when it can work and to prevent it when it cannot. This
could be kconfig, DT, or run time probing of silicon revisions, but I
don't have access to this hardware, and so I can't really say how to
fix it.

Just for the record, I did in fact review this patch, and I commented
on exactly this point. Frank said we would address this point, and he
did so. Not knowing the imx family very well, I took his word for it.
After all, Frank has a Freescale address, and I would expect a
Freescale employee to know how to provide the right fix.

Thanks,
Richard
