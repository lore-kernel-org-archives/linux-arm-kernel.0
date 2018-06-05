From: robh@kernel.org (Rob Herring)
Date: Tue, 5 Jun 2018 13:41:24 -0600
Subject: [PATCH v4 1/6] Documentation: DT: Consolidate SP805 binding docs
In-Reply-To: <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
 <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
Message-ID: <20180605194124.GA26885@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 11:01:32AM -0700, Ray Jui wrote:
> Consolidate two SP805 binding documents "arm,sp805.txt" and
> "sp805-wdt.txt" into "arm,sp805.txt" that matches the naming of the
> desired compatible string to be used
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  .../devicetree/bindings/watchdog/arm,sp805.txt     | 27 ++++++++++++++-----
>  .../devicetree/bindings/watchdog/sp805-wdt.txt     | 31 ----------------------
>  2 files changed, 20 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt

Would be good to get a ACK from FSL/NXP person on this. It looks to me 
like the driver fetches the wrong clock as it gets the first one and the 
driver really wants 'wdog_clk'. In any case, their dts files should be 
updated.

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
