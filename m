From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 16 Feb 2017 12:32:24 +0100
Subject: [PATCH v4 33/36] media: imx: redo pixel format enumeration and
 negotiation
In-Reply-To: <1487211578-11360-34-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-34-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1487244744.2377.38.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-02-15 at 18:19 -0800, Steve Longerbeam wrote:
> The previous API and negotiation of mbus codes and pixel formats
> was broken, and has been completely redone.
> 
> The negotiation of media bus codes should be as follows:
> 
> CSI:
> 
> sink pad     direct src pad      IDMAC src pad
> --------     ----------------    -------------
> RGB (any)        IPU RGB           RGB (any)
> YUV (any)        IPU YUV           YUV (any)
> Bayer              N/A             must be same bayer code as sink

The IDMAC src pad should also use the internal 32-bit RGB / YUV format,
except if bayer/raw mode is selected, in which case the attached capture
video device should only allow a single mode corresponding to the output
pad media bus format.

regards
Philipp
