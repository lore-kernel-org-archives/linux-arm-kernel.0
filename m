From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 May 2015 14:23:12 +0100
Subject: [PATCH 12/12] i2c: pxa: enable/disable i2c module across msg xfer
In-Reply-To: <1432818224-17070-13-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-13-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150528132312.GC2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 06:33:44PM +0530, Vaibhav Hiremath wrote:
> From: Yi Zhang <yizhang@marvell.com>
> 
> Enable i2c module/unit before transmission and disable when it finishes.
> 
> why?
> It's because the i2c bus may be distrubed if the slave device,
> typically a touch, powers on.

"disturbed"

I'd recommend that this is a DT property - not every platform is going to
want this, and as there is rudimentary I2C slave support in this driver,
this change breaks that.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
