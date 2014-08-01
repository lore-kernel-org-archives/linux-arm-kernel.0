From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 01 Aug 2014 20:29:04 +0300
Subject: [PATCH 2/2] spi: davinci: add support to configure gpio cs through
 dt
In-Reply-To: <53DBB202.1040509@ti.com>
References: <1406827995-30913-1-git-send-email-grygorii.strashko@ti.com>
 <1406827995-30913-3-git-send-email-grygorii.strashko@ti.com>
 <20140731193515.GO17528@sirena.org.uk> <53DBB202.1040509@ti.com>
Message-ID: <53DBCE60.1010308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 08/01/2014 06:28 PM, Grygorii Strashko wrote:
> Hi Mark,
> On 07/31/2014 10:35 PM, Mark Brown wrote:
>> On Thu, Jul 31, 2014 at 08:33:15PM +0300, Grygorii Strashko wrote:
>>
>>> +	if (np && master->cs_gpios != NULL && spi->cs_gpio >= 0) {
>>> +		/* SPI core parse and update master->cs_gpio */
>>>    		gpio_chipsel = true;
>>> +		gpio = spi->cs_gpio;
>>> +	} else if (pdata->chip_sel &&
>>> +		   chip_sel < pdata->num_chipselect &&
>>> +		   pdata->chip_sel[chip_sel] != SPI_INTERN_CS) {
>>> +		/* platform data defines chip_sel */
>>> +		gpio_chipsel = true;
>>> +		gpio = pdata->chip_sel[chip_sel];
>>> +	}
>>
>> This would all be a lot simpler and more direct if you were to arrange
>> to use cs_gpio in the struct spi_device, and move you closer to
>> converting to use more of the core functionality.
> 
> Unfortunately, I'm not sure this is good idea, because this part of
> code is used by Davinci arch which is non-DT platform.
> As result, this code was kept mostly unchanged.
> 
> I can try to rework it, but I'd like to do it as standalone patch.
> Is it ok for you?

I've just sent updated version with additional patch where
I reworked driver for using cs_gpio for  both DT and non-DT cases.
http://www.spinics.net/lists/arm-kernel/msg352382.html

Regards,
-grygorii
