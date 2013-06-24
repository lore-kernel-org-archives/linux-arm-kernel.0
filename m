From: davidb@codeaurora.org (David Brown)
Date: Mon, 24 Jun 2013 13:55:21 -0700
Subject: [PATCH] ARM: Fix dtb dependency to use order-only prerequisites
In-Reply-To: <1372106517-19105-1-git-send-email-dianders@chromium.org>
References: <1372106517-19105-1-git-send-email-dianders@chromium.org>
Message-ID: <20130624205521.GA25530@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 01:41:57PM -0700, Doug Anderson wrote:
>The %.dtb dependency is specified to depend on the PHONY "scripts".
>That means that it'll build every time even if the underlying dtb file
>hasn't been touched.  Use an order-only prerequisites to fix this.
>Also mark "dtbs" as PHONY for correctness.
>
>This was broken in (70b0476 ARM: 7513/1: Make sure dtc is built before
>running it).
>
>Reported-by: Mike Frysinger <vapier@gentoo.org>
>Signed-off-by: Doug Anderson <dianders@chromium.org>
>---
> arch/arm/Makefile | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: David Brown <davidb@codeaurora.org>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
