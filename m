From: broonie@kernel.org (Mark Brown)
Date: Fri, 13 Sep 2013 11:02:02 +0100
Subject: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
In-Reply-To: <523266EC.1060501@intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
 <52323AC8.30403@gmail.com> <523266EC.1060501@intel.com>
Message-ID: <20130913100202.GB29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 09:14:20AM +0800, Aaron Lu wrote:
> On 09/13/2013 06:06 AM, Sylwester Nawrocki wrote:

> > So there is currently no way to avoid this behaviour, i.e. to have the 
> > adapter
> > not activated before any of its client devices is probed, but only later on,
> > after explicit call to pm_runtime_get*(&client->dev) in the client driver ?

> The above pm_runtime_get_sync is used to make sure when the client I2C
> device is going to be probed, its host adapter device is turned on(or we
> will fail the probe). It doesn't affect the adapter's status before the
> probe of I2C client device.

The expecation is that if the adaptor needs to do anything to transfer
it'll do that when asked to transfer - that way it can sit in a low
power state when the bus is idle.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130913/a7dc354f/attachment.sig>
