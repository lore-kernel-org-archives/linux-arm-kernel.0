From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 3 Mar 2011 15:22:42 +0000
Subject: [Qualcomm PM8921 MFD 2/6] mfd: pm8xxx: Add irq support
In-Reply-To: <4D6F1B2B.3090706@codeaurora.org>
References: <1299104001-5240-1-git-send-email-adharmap@codeaurora.org>
	<1299104001-5240-3-git-send-email-adharmap@codeaurora.org>
	<20110302224616.GB32325@opensource.wolfsonmicro.com>
	<4D6F1B2B.3090706@codeaurora.org>
Message-ID: <20110303152242.GB32234@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2011 at 08:38:03PM -0800, Abhijeet Dharmapurikar wrote:
> Mark Brown wrote:

> >Is it really useful to register a struct device purely for the interrupt
> >controller?  I'd have expected this to be core functionality of the
> >device.  The fact that you need to store the device at all is a bit odd
> >too as you're using the MFD API.

> This design is slightly different from other MFD drivers.
> I separated the interrupt from the core because the interrupt
> implementation for different Qualcomm pmics remains the same. On
> 8660 FFA boards for example, we have two pmic chips that have the
> same interrupt subdevice implementation (the number of interrupts
> managed by each is different). I didn't want to duplicate the exact
> code in the core driver - hence a separate interrupt driver.

Could you deal with this with a library instead?

> With that in mind, the driver has following functions
> pm8xxxx_read_root
> pm8xxxx_read_master
> pm8xxxx_read_block

> Do you still think I should change the name?

I'd suggest adding an _irq in there.
