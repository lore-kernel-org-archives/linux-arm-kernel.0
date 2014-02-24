From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 24 Feb 2014 18:41:21 +0100
Subject: [RFC PATCH v3 1/9] staging: imx-drm-core: don't request probe
 deferral in imx_drm_encoder_parse_of
In-Reply-To: <20140224170653.GO21483@n2100.arm.linux.org.uk>
References: <1392723370-4772-1-git-send-email-p.zabel@pengutronix.de>
 <1392723370-4772-2-git-send-email-p.zabel@pengutronix.de>
 <20140224154919.GL21483@n2100.arm.linux.org.uk>
 <1393260998.3091.63.camel@pizza.hi.pengutronix.de>
 <20140224170653.GO21483@n2100.arm.linux.org.uk>
Message-ID: <1393263681.3091.84.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 24.02.2014, 17:06 +0000 schrieb Russell King - ARM Linux:
> On Mon, Feb 24, 2014 at 05:56:38PM +0100, Philipp Zabel wrote:
> > Am Montag, den 24.02.2014, 15:49 +0000 schrieb Russell King - ARM Linux:
> > One issue was that the DT parsing code would try to add the imx-ldb
> > component right after the first crtc, and then its bind would fail
> > in imx_drm_encoder_parse_of because the three remaining crtcs were
> > not yet registered. This is already fixed by adding the crtc
> > components first.
> 
> That's what happens anyway - we add /all/ the CRTCs first before we
> start adding the connectors.

Yes, I know. I accidentally removed that feature when I switched to
parsing the OF graph instead of the crtcs and encoder properties, but
I've fixed this again in v3 without moving this patch out of the way.

regards
Philipp
