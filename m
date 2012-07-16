From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 16 Jul 2012 15:41:51 +0200
Subject: [RFC internal PATCH] mfd/mc13xxx: drop modifying driver's
 id_table in probe
In-Reply-To: <1342006608-30550-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1342006608-30550-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120716134151.GH20652@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Jul 11, 2012 at 01:36:48PM +0200, Uwe Kleine-K?nig wrote:
> This was introduced in commit
> 
> 	876989d (mfd: Add device tree probe support for mc13xxx)
> 
> for spi and later while introducing support for i2c copied to the i2c
> driver.
> 
> Modifying driver details is very strange, for example probing an
> mc13892 device (instantiated via dt) removes the driver's ability to
> handle (traditionally probed) mc13783 devices in this case.
> I'm not aware of any problems that make this hack necessary and if
> there were some, they'd have to be fixed in the spi/i2c core, not in
> a driver.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello Samuel,
> 
> even though this qualifies as fix, I don't think it's necessary to annoy
> Linus with it for 3.5. Usually there is only one pmic on each machine so
> it's not grave when probing one device disables support for another.
I agree, and I'm pushing this one for the next merge window.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
