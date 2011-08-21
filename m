From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 22 Aug 2011 01:09:52 +0200
Subject: [PATCH v3] mfd:fix section mismatch warning in ab3550-core
In-Reply-To: <1312432351-15729-1-git-send-email-gaowanlong@cn.fujitsu.com>
References: <20110803083255.GJ9250@pengutronix.de>
	<1312432351-15729-1-git-send-email-gaowanlong@cn.fujitsu.com>
Message-ID: <20110821230952.GB4607@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gao,

On Thu, Aug 04, 2011 at 12:32:31PM +0800, Wanlong Gao wrote:
> This patch fixes:
> WARNING: drivers/mfd/built-in.o(.data+0x9998): Section mismatch in reference from the variable ab3550_driver to the function .init.text:ab3550_probe()
> The variable ab3550_driver references
> the function __init ab3550_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Patch applied, thanks a lot.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
