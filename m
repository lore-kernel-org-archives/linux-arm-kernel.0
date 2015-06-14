From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Jun 2015 16:13:31 +0100
Subject: [PATCH v5 06/17] video: backlight: add new locomo backlight driver
In-Reply-To: <1433797008-6246-7-git-send-email-dbaryshkov@gmail.com>
References: <1433797008-6246-1-git-send-email-dbaryshkov@gmail.com>
 <1433797008-6246-7-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20150614151331.GE7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 11:56:37PM +0300, Dmitry Eremin-Solenikov wrote:
> Add new simple backlight driver - it cares only about PWM/frontlight
> part of LoCoMo, it does not touch TFT settings and does not export TFT
> power control.

Is there a reason not to model the PWM as a PWM device, and use pwm_bl.c ?
pwm_bl.c can be used in non-DT setups too.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
