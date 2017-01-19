From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 19 Jan 2017 15:46:41 +0100
Subject: [PATCH v2] ARM: dts: imx: Pass 'chosen' and 'memory' nodes
In-Reply-To: <CAOMZO5AdgM9eFnerLRdYxwE7gsOE5OvkWs6rCR4zta1XmXHj1A@mail.gmail.com>
References: <1484834566-19845-1-git-send-email-fabio.estevam@nxp.com>
 <20170119141335.kpbrbpbwaovnijjv@pengutronix.de>
 <CAOMZO5AdgM9eFnerLRdYxwE7gsOE5OvkWs6rCR4zta1XmXHj1A@mail.gmail.com>
Message-ID: <20170119144641.jxj2bqg5uqjol23x@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 12:35:40PM -0200, Fabio Estevam wrote:
> Hi Uwe,
> 
> On Thu, Jan 19, 2017 at 12:13 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > Would it be nice to add a comment about why this was added? Something to
> > prevent a cleanup like "remove empty nodes and invalid memory
> > configurations".
> 
> Do you mean something like this?
> 
> /* "chosen" and "memory" nodes are mandatory */
> chosen {};
> memory { device_type = "memory"; reg = <0 0>; };

Not very helpful comment. Something like:

	/*
	 * The decompressor relies on a pre-existing chosen node to be                                                          
	 * available to insert the command line and merge other ATAGS
	 * info.
	 */

Is it difficult to fix the decompressor?

I didn't understood the breakage regarding the memory node good enough
to suggest a comment for that.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
