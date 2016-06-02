From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 02 Jun 2016 14:55:24 +0200
Subject: [PATCH 2/5] arm/dts/imx6q-b850v3: Configure IPU assignment order
In-Reply-To: <1464626385-19253-3-git-send-email-peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
 <1464626385-19253-3-git-send-email-peter.senna@collabora.com>
Message-ID: <1464872124.3307.22.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 30.05.2016, 18:39 +0200 schrieb Peter Senna Tschudin:
> Configure the IPU assignment order to assign one IPU per external
> display. A single IPU can drive multiple external displays but there are
> resolution restrictions. After this patch the GPU is capalbe of driving two
> Full-HD monitors.

It's also capable to do it before this patch, if you use the first and
third crtc. You are just reordering the crtcs.
Unfortunately the IPU has combined limitations across multiple crtcs in
one IPU, which currently can't be communicated to userspace.

regards
Philipp
