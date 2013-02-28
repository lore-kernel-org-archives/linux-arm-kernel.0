From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 28 Feb 2013 11:40:55 +0200
Subject: [PATCH 3/3] USB mxs-phy: Register phy with framework
In-Reply-To: <512F21A5.2040303@pengutronix.de>
References: <1361974590-21237-1-git-send-email-mkl@pengutronix.de>
 <1361974590-21237-4-git-send-email-mkl@pengutronix.de>
 <20130228080127.GB6544@arwen.pp.htv.fi> <512F21A5.2040303@pengutronix.de>
Message-ID: <87y5e8wzbs.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> On 02/28/2013 09:01 AM, Felipe Balbi wrote:
>> hi,
>> 
>> On Wed, Feb 27, 2013 at 03:16:30PM +0100, Marc Kleine-Budde wrote:
>>> From: Sascha Hauer <s.hauer@pengutronix.de>
>>>
>>> We now have usb_add_phy_dev(), so use it to register with the framework
>>> to be able to find the phy from the USB driver.
>>>
>>> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> Reviewed-by: Peter Chen <peter.chen@freescale.com>
>>> Acked-by: Felipe Balbi <balbi@ti.com>
>>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> 
>> any chance you can move away from {write,read}[bwl]_relaxed() so we can
>> build this driver on other architectures ?
>
> The hardware is in the ARM imx2{2,8} only. Another option would be to
> add an "depends on ARCH_ARM".

Doesn't mean that we shouldn't be able to compile-test the driver.

Regards,
--
Alex
