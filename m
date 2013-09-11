From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 11 Sep 2013 18:12:43 +0200
Subject: [PATCH v2 6/9] mfd: wm8994: convert to use I2C core runtime PM
In-Reply-To: <1378913560-2752-7-git-send-email-mika.westerberg@linux.intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-7-git-send-email-mika.westerberg@linux.intel.com>
Message-ID: <20130911161242.GA13015@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mika,

On Wed, Sep 11, 2013 at 06:32:37PM +0300, Mika Westerberg wrote:
> The I2C core now prepares runtime PM on behalf of the I2C client device, so
> only thing the driver needs to do is to call pm_runtime_put() at the end of
> its ->probe().
> 
> This patch converts wm8994 driver to use this model.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

I think it would make more sense for you to merge that one together with
the related i2c changes. If you prefer that I take it through MFD,
please let me know.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
