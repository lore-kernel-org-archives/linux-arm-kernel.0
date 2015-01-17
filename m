From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Jan 2015 22:40:21 +0000
Subject: [PATCH v4 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <54BAD391.9080909@broadcom.com>
References: <1421274213-3544-1-git-send-email-rjui@broadcom.com>
 <1421274213-3544-3-git-send-email-rjui@broadcom.com>
 <20150115084119.GN22880@pengutronix.de>
 <54B98C18.4080807@broadcom.com>
 <20150117160113.GA22880@pengutronix.de>
 <54BABEE9.8070801@broadcom.com>
 <20150117201849.GC22880@pengutronix.de>
 <54BACB66.6040909@broadcom.com>
 <20150117211017.GD22880@pengutronix.de>
 <54BAD391.9080909@broadcom.com>
Message-ID: <20150117224021.GA26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 01:26:41PM -0800, Ray Jui wrote:
> 	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);
> 
> 	/* disable all interrupts */
> 	writel(0, iproc_i2c->base + IE_OFFSET);
> 
> 	if (!time_left && !atomic_read(&iproc_i2c->transfer_is_successful)) {

Why are you using atomic_read() here?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
