From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Mar 2015 15:46:11 +0000
Subject: [PATCH 2/2] soc: mediatek: Add PMIC wrapper for MT8135 and
 MT8173 SoCs
In-Reply-To: <1426000954-7647-3-git-send-email-s.hauer@pengutronix.de>
References: <1426000954-7647-1-git-send-email-s.hauer@pengutronix.de>
 <1426000954-7647-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150310154610.GP8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 04:22:34PM +0100, Sascha Hauer wrote:
> +	for (i = 0; i < 4; i++) {
> +		pwrap_writel(wrp, i, PWRAP_SIDLY);
> +		pwrap_read(wrp, PWRAP_DEW_READ_TEST, &rdata);
> +		printk("%s: 0x%04x\n", __func__, rdata);

Is this really ready for submission, or is this just a hidden oversight?

What I tend to do with such debugging is _not_ to indent it at all, which
means when the file is reviewed before sending it out (or indeed, when
diffing it to review the updates before committing those changes or an
amendment to the previous commit) that it sticks out like a sore thumb.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
