From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 8 Nov 2011 16:36:00 +0000
Subject: [PATCH] ARM: S3C6410: Use device names for both I2C clocks
In-Reply-To: <CAJuYYwTM4M-dt6mMgOH2TLEbBx7CgmiNVaB2VqYN-YMLYHqaZg@mail.gmail.com>
References: <1320768593-21010-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAJuYYwTM4M-dt6mMgOH2TLEbBx7CgmiNVaB2VqYN-YMLYHqaZg@mail.gmail.com>
Message-ID: <20111108163600.GF5632@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 09:57:56PM +0530, Thomas Abraham wrote:
> On 8 November 2011 21:39, Mark Brown

> > +#ifdef CONFIG_S3C_DEV_I2C1
> > + ? ? ? ? ? ? ? .devname ? ? ? ?= "s3c2440-i2c.0",
> > +#else
> > + ? ? ? ? ? ? ? .devname ? ? ? ?= "s3c2440-i2c",
> > +#endif

> The #ifdef around the id of the s3c_device_i2c0 structure in
> arch/arm/plat-samsung/devs.c file can be removed and id can be fixed
> as 0. And devname "s3c2440-i2c.0" can be assigned above without the
> #ifdef. Will there be any issues in using .id as 0 even if there is
> only one instance of i2c?

That would be much nicer from my point of view but it's much more
invasive as this device is used by a whole raft of other SoCs, not all
of which have more than one I2C controller and I don't really feel like
changing the idiom over the entire Samsung SoC family right now.
