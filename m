From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 29 Jun 2012 15:52:49 +0100
Subject: [PATCH 03/15] mfd: Make MFD core code Device Tree and IRQ domain
 aware
In-Reply-To: <20120629145503.GF22806@sortiz-mobl>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-4-git-send-email-lee.jones@linaro.org>
 <20120629145503.GF22806@sortiz-mobl>
Message-ID: <4FEDC141.8090000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/06/12 15:55, Samuel Ortiz wrote:
> Hi Lee,
>
> On Wed, Jun 20, 2012 at 01:56:39PM +0100, Lee Jones wrote:
>> During Device Tree enablement of the ab8500 and db8500-prcmu drivers,
>> a decision was made to omit registration through the MFD API and use
>> Device Tree directly. However, because MFD devices have a different
>> address space and the ab8500 and db8500 both use I2C to communicate,
>> this causes issues with address translation during execution of
>> of_platform_populate(). So the solution is to make the MFD core aware
>> of Device Tree and have it assign the correct node pointers instead.
>>
>> To make this work the MFD core also needs to be awere of IRQ domains,
>> as Device Tree insists on IRQ domain compatibility. So, instead of
>> providing an irq-base via platform code, in the DT case we simply
>> look up the IRQ domain and map to the correct virtual IRQ.
>>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>   drivers/mfd/mfd-core.c   |   31 +++++++++++++++++++++++++++----
>>   include/linux/mfd/core.h |    1 +
>>   2 files changed, 28 insertions(+), 4 deletions(-)
> Applied, after changing the code style a bit to make it more readable.
> Could you please provide me with a follow up patch for documenting the
> of_compatible MFD cell field, please ?

Yes, of course.

What exactly would you like? Something in Documentation/devicetree you 
mean? Or something else?

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
