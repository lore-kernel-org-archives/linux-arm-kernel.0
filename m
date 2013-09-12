From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 12 Sep 2013 14:29:20 -0700
Subject: [PATCH v2 5/9] drivers/misc: convert existing I2C clients driver
 to use I2C core runtime PM
In-Reply-To: <1378913560-2752-6-git-send-email-mika.westerberg@linux.intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-6-git-send-email-mika.westerberg@linux.intel.com>
Message-ID: <20130912212920.GA11384@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 06:32:36PM +0300, Mika Westerberg wrote:
> The I2C core now prepares runtime PM on behalf of the I2C client device, so
> only thing the driver needs to do is to call pm_runtime_put() at the end of
> its ->probe().
> 
> This patch converts I2C client drivers under drivers/misc to use this
> model.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
