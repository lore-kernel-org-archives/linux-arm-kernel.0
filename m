From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Sep 2012 14:28:21 +0000
Subject: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the Nomadik
 I2C driver
In-Reply-To: <20120903152012.GH31163@gmail.com>
References: <20120831122323.GC5962@gmail.com> <5044C82E.5060207@gmail.com>
 <20120903152012.GH31163@gmail.com>
Message-ID: <201209041428.21409.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 September 2012, Lee Jones wrote:
> > But if you are handling both, then I agree that platform_data should
> > override DT.
> 
> I do agree with this, but I haven't stumbled over such a use-case yet.
> I have only provided; clock names, DMA settings and call-back information
> via AUX_DATA() thus far, and those are being removed too when a) the 
> correct bindings are mainlined and b) I have the time.

I'd prefer if you just disallow the case where pdata and DT have conflicting
information. We don't seem to have a clear rule that is enforced over the
kernel, so I don't think we can rely on either one taking precedence over
the other in general.

In this particular case, we don't have a single board file providing a
struct nmk_i2c_controller definition for platform data, so the best way
to handle this IMHO is to remove the header file with the platform
data definition, and just encode the defaults in the driver.

	Arnd
