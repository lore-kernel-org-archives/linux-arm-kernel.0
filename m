From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 7 Oct 2015 12:22:02 +0100
Subject: [PATCH v2 5/9] dmaengine: st_fdma: Add xp70 firmware loading
 mechanism.
In-Reply-To: <1441980871-24475-6-git-send-email-peter.griffin@linaro.org>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-6-git-send-email-peter.griffin@linaro.org>
Message-ID: <20151007112201.GB4810@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 03:14:27PM +0100, Peter Griffin wrote:
> This patch adds the code to load the xp70 fdma firmware
> using the asynchronous request_firmware_nowait call
> so as not to delay bootup of builtin code.

Okay we need to check here. Can the driver be built in, if so this is not
the right usage. You should load the firmware on first open for this device

See https://lkml.org/lkml/2015/8/26/588

-- 
~Vinod
