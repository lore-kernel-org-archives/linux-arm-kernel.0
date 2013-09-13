From: broonie@kernel.org (Mark Brown)
Date: Fri, 13 Sep 2013 10:59:50 +0100
Subject: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
In-Reply-To: <20130913065434.GZ7393@intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
 <87vc25pvvm.fsf@linaro.org> <20130913065434.GZ7393@intel.com>
Message-ID: <20130913095950.GA29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 09:54:34AM +0300, Mika Westerberg wrote:
> On Thu, Sep 12, 2013 at 02:34:21PM -0700, Kevin Hilman wrote:

> > For hardware that is disabled/powered-off on startup, there will now be
> > a mismatch between the hardware state an the RPM core state.

> The call to pm_runtime_get_noresume() should make sure that the device is
> in active state (at least in state where it can access the bus) if I'm
> understanding this right.

Accessing the bus isn't an issue for I2C outside of ACPI, the power
management of the device is totally disassociated from the bus and the
controller is responsible for ensuring it is available during transfers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130913/cd1bd731/attachment.sig>
