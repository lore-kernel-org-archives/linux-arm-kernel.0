From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 17 Sep 2013 13:07:37 +0200
Subject: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
In-Reply-To: <20130916084708.GN7393@intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
 <87vc25pvvm.fsf@linaro.org> <20130913065434.GZ7393@intel.com>
 <52332BF0.4060605@samsung.com> <20130913154013.GD7393@intel.com>
 <5235BA9C.1090509@gmail.com> <20130916084708.GN7393@intel.com>
Message-ID: <523837F9.1020204@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2013 10:47 AM, Mika Westerberg wrote:
> I'm actually thinking that it is probably better now if we don't touch the
> client runtime PM at all in the I2C core.
> 
> I proposed a less intrusive solution in this same thread where we power the
> I2C controller briefly at the client ->probe() (In order to have all the
> ACPI power resources etc. and the controller on) and let the client driver
> handle their own runtime PM as they do currently.
> 
> Do you think that would work better wrt. fimc-isp-i2c driver?

That would be no different for this particular driver, as long as the 
I2C bus controller is activated right before the I2C client's probe().
 
In general I would expect such additional device activation not to be 
harmful. For that particular driver I'm going to prepare patches to 
ensure that the I2C bus controller device and its driver is registered 
only when a driver it depends on has initialized. This should have been 
ensured right from the beginning. So don't need to worry about this 
particular case. I'm just not sure what other devices could be similarly
affected.
