From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Tue, 21 Mar 2017 16:33:29 -0700
Subject: [PATCH v5 38/39] media: imx: csi: fix crop rectangle reset in
 sink set_fmt
In-Reply-To: <1490030604.2917.103.camel@pengutronix.de>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <1489121599-23206-39-git-send-email-steve_longerbeam@mentor.com>
 <20170319152233.GW21222@n2100.armlinux.org.uk>
 <327d67d9-68c1-7f74-0c0f-f6aee1c4b546@gmail.com>
 <1490010926.2917.59.camel@pengutronix.de>
 <20170320120855.GH21222@n2100.armlinux.org.uk>
 <1490018451.2917.86.camel@pengutronix.de>
 <20170320141705.GL21222@n2100.armlinux.org.uk>
 <1490030604.2917.103.camel@pengutronix.de>
Message-ID: <80b516fe-6050-c122-1de6-9235bc7ade68@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp, Russell,


On 03/20/2017 10:23 AM, Philipp Zabel wrote:
> Hi Steve, Russell,
>
> <snip>
>
> What do you think of this:
>
> ----------8<----------
> From 2830aebc404bdfc9d7fc1ec94e5282d0b668e8f6 Mon Sep 17 00:00:00 2001
> From: Philipp Zabel <p.zabel@pengutronix.de>
> Date: Mon, 20 Mar 2017 17:10:21 +0100
> Subject: [PATCH] media: imx: csi: add sink selection rectangles
>
> Move the crop rectangle to the sink pad and add a sink compose rectangle
> to configure scaling. Also propagate rectangles from sink pad to crop
> rectangle, to compose rectangle, and to the source pads both in ACTIVE
> and TRY variants of set_fmt/selection, and initialize the default crop
> and compose rectangles.
>


I applied this patch.

I noticed Philipp fixed a bug in the sink->source pad format
propagation. I was only propagating the active runs, and not
the trial runs. I fixed this everywhere in the pipeline, applied
to the "propagate sink pad formats to source pads" patch. Try
runs should now work correctly across the whole pipeline, but
I haven't tested this.

Steve
