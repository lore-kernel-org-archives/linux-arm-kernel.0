From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 Mar 2011 15:13:55 +0000
Subject: [Qualcomm PM8921 MFD v2 4/6] mfd: pm8xxx-mpp: Add pm8xxx MPP
	driver
In-Reply-To: <4D784730.4010307@codeaurora.org>
References: <1299564590-30116-1-git-send-email-adharmap@codeaurora.org>
	<1299564590-30116-5-git-send-email-adharmap@codeaurora.org>
	<20110308233045.GB2717@opensource.wolfsonmicro.com>
	<4D784730.4010307@codeaurora.org>
Message-ID: <20110310151355.GD7411@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2011 at 07:36:16PM -0800, Abhijeet Dharmapurikar wrote:
> Mark Brown wrote:

>> It's seems really odd that you're adding gpiolib stuff here when you've
>> also got a separate gpiolib driver.  Possibly this all shouldn't
>> actually be split up as much as it is - there's also the issue with the
>> gpiolib driver needing to peer into the interrupt controller.  It might
>> simplify the code if things were merged more.

> I dont think merging code will help here. gpio lines and mpp lines are  
> very different piece of hardware,they have a different register map and  
> different config attributes. They do fall under the generic 'gpiolib'  
> umbrella, but it seems clean to keep them separate.

Oh, so the MFPs are completely separate pins to the GPIOs controlled by
the GPIO driver?  That's unusual - might be worth clarifying that
somehow.
