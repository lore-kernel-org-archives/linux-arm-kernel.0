From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 16 Oct 2015 11:36:59 +0200
Subject: [PATCH v2] pwm-backlight: fix the panel power sequence
In-Reply-To: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
References: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
Message-ID: <1444988219.3541.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 16.10.2015, 17:17 +0800 schrieb YH Huang:
> In order to match the panel power sequence, disable the enable_gpio
> in the probe function. Also, reorder the code in the power_on and
> power_off function to match the timing.

Could you also have a look at the "pwm-backlight: Avoid backlight
flicker when probed from DT" patch?
I think in case of a panel left enabled by the bootloader, your patch
will disable the backlight for a short time.

best regards
Philipp
