From: graeme.gregory@linaro.org (Graeme Gregory)
Date: Mon, 16 Sep 2013 15:46:16 +0100
Subject: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
In-Reply-To: <20130916143811.GP7393@intel.com>
References: <20130913065434.GZ7393@intel.com> <87bo3whjz4.fsf@linaro.org>
 <20130913145022.GC7393@intel.com> <20130913173149.GE7393@intel.com>
 <87ioy4e8bw.fsf@linaro.org> <20130915064139.GJ7393@intel.com>
 <20130915124744.GW29403@sirena.org.uk>
 <20130915132823.GL7393@intel.com>
 <20130916101249.GX29403@sirena.org.uk>
 <20130916143811.GP7393@intel.com>
Message-ID: <20130916144616.GM1823@xora-yoga.xora.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 05:38:12PM +0300, Mika Westerberg wrote:
> On Mon, Sep 16, 2013 at 11:12:49AM +0100, Mark Brown wrote:
> > That's definitely an ACPI specific (probably x86 specific ACPI?)
> > requirement not a generic one, on some systems it would increase power
> > consumption since the controller will need to sit on while the device is
> > functioning autonomously.
> 
> Yes, the ACPI 5.0 spec says that the device cannot be in higher D-state
> than its parent. This is not x86 specific, though I'm not sure if this is
> implemented elsewhere.
> 
I do not think this stops the OS fine controlling the power of the device
though. It is only a mechanism to make sure the tree of D states is vaguely
sane from the ACPI point of view. What happens in each D state is never
actually defined in the ACPI spec.

Graeme
