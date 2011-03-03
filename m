From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Thu, 03 Mar 2011 14:55:00 -0800
Subject: [Qualcomm PM8921 MFD 2/6] mfd: pm8xxx: Add irq support
In-Reply-To: <20110303152242.GB32234@opensource.wolfsonmicro.com>
References: <1299104001-5240-1-git-send-email-adharmap@codeaurora.org>
	<1299104001-5240-3-git-send-email-adharmap@codeaurora.org>
	<20110302224616.GB32325@opensource.wolfsonmicro.com>
	<4D6F1B2B.3090706@codeaurora.org>
	<20110303152242.GB32234@opensource.wolfsonmicro.com>
Message-ID: <4D701C44.7090506@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> On Wed, Mar 02, 2011 at 08:38:03PM -0800, Abhijeet Dharmapurikar wrote:
>> Mark Brown wrote:
> 
>>> Is it really useful to register a struct device purely for the interrupt
>>> controller?  I'd have expected this to be core functionality of the
>>> device.  The fact that you need to store the device at all is a bit odd
>>> too as you're using the MFD API.
> 
>> This design is slightly different from other MFD drivers.
>> I separated the interrupt from the core because the interrupt
>> implementation for different Qualcomm pmics remains the same. On
>> 8660 FFA boards for example, we have two pmic chips that have the
>> same interrupt subdevice implementation (the number of interrupts
>> managed by each is different). I didn't want to duplicate the exact
>> code in the core driver - hence a separate interrupt driver.
> 
> Could you deal with this with a library instead?

Can you please clarify what a library means here?

>> pm8xxxx_read_block
> 
>> Do you still think I should change the name?
> 
> I'd suggest adding an _irq in there.
Ok will do.

--
Sent by an employee of the Qualcomm Innovation Center, Inc. The Qualcomm 
Innovation Center, Inc. is a member of the Code Aurora Forum.
