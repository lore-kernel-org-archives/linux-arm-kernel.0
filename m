From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 3 Mar 2011 22:55:54 +0100
Subject: [PATCH 0/4] OMAP 3 and 4 i2c fixes
In-Reply-To: <20110303134744.30648.91218.stgit@otae.warmcat.com>
References: <20110303134744.30648.91218.stgit@otae.warmcat.com>
Message-ID: <4D700E6A.10409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To summarize my comments on your series.

On 3/3/2011 2:50 PM, Andy Green wrote:
> The following series fixes two issues with OMAP 3 and 4 i2c support.
>
> First, hwmod tables don't have the i2c units marked up as being
> for 16-bit access only, which is mandatory.

That part is OK, and should just be extended to 2430 for the sake of 
completeness. A rev attribute should be added as well for the second part.

> Second, the i2c peripheral unit init code is confused about using
> cpu_is...() and probed peripheral unit version, leading to OMAP3
> i2c code doing the wrong thing and accessing nonexistant registers.

That part should be revisited to use a better way to identify the IP 
revision.

Most of the code is there, you just have to copy the correct information 
during I2C device init.

Just let me know if you are not comfortable with that latest part, some 
l-o folks, including me, can help you.

Thanks,
Benoit
