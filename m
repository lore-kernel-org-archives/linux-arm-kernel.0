From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 02 Jun 2016 16:59:55 -0700
Subject: [PATCH v3 09/12] EXAMPLE CODE: usb: port: Parse pwrseq phandle
 from Device Tree
In-Reply-To: <20160602012419.GA7953@shlinux2>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
 <1464768141-25420-10-git-send-email-k.kozlowski@samsung.com>
 <146477144362.1485.3331887341591876278@sboyd-linaro>
 <20160601120520.GB16740@shlinux2>
 <146480499491.3686.4996610748316511864@sboyd-linaro>
 <20160602012419.GA7953@shlinux2>
Message-ID: <146491199510.7580.5649614149557346848@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-06-01 18:24:19)
> On Wed, Jun 01, 2016 at 11:16:34AM -0700, Stephen Boyd wrote:
> > > 
> > > No, you may need to do reset before enumeration, the general purpose of
> > > reset is eliminate unstable hardware state, and let the controller find
> > > the device.
> > > 
> > > Try to do it at bootloader to see if it works for you.
> > > 
> > 
> > Sorry the bootloader doesn't do this so that doesn't work for me.
> 
> I mean try to see if the HUB can work if you reset it at bootloader.
> If it works, it means you need to do reset before enumeration, and you
> don't need to do anything after enumeration.
> 

Ah ok. Yes, I need to deassert the reset before enumeration. Right now I
have a driver for the 4604 hub controller that deasserts a reset gpio
and sends an i2c command to put the controller into "hub" mode. If I do
this before the usb controller driver probes then everything works. If I
do it after the controller probes it doesn't.
