From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 17 Jun 2014 12:57:13 +0200
Subject: [PATCH v2 06/10] mfd: Add driver for Maxim 77802 Power Management
 IC
In-Reply-To: <20140616192720.GK5099@sirena.org.uk>
References: <1402941758-11216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402941758-11216-7-git-send-email-javier.martinez@collabora.co.uk>
 <20140616192720.GK5099@sirena.org.uk>
Message-ID: <53A01F09.5070106@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 06/16/2014 09:27 PM, Mark Brown wrote:
> On Mon, Jun 16, 2014 at 08:02:34PM +0200, Javier Martinez Canillas wrote:
> 
>> +- max77802,pmic-buck-dvs-gpios: The DVS GPIOs. We'll try to set these GPIOs
>> +  to match pmic-buck-default-dvs-idx at probe time if they are defined. If
>> +  some or all of these GPIOs are not defined it's assumed that the board has
>> +  any missing GPIOs hardwired to match pmic-buck-default-dvs-idx.
> 
> I can't tell from reading this what the property means exactly - I
> expect it is an array of the GPIOs in some order but that order isn't
> specified.
> 

Ok, I'll improve this property documentation.

>> +config MFD_MAX77802
>> +	tristate "Maxim Integrated MAX77802 PMIC Support"
>> +	depends on I2C=y
>> +	select MFD_CORE
>> +	select REGMAP_I2C
>> +	select REGMAP_IRQ
>> +	select IRQ_DOMAIN
>> +	help
>> +	  Say yes here to support for Maxim Integrated MAX77802.
>> +	  This is a Power Management IC with RTC on chip.
>> +	  This driver provides common support for accessing the device;
>> +	  additional drivers must be enabled in order to use the functionality
>> +	  of the device.
>> +
> 
> It is a bit unorthodox to put the build infrastructure in the same patch
> as the DT binding...
> 

I thought it was the opposite. That a DT binding document has to be added along
with the first user of the binding but I'll separate the DT doc in another patch
then if that is the right thing to do.

Thanks a lot for all your suggestions, I'll wait a little to see if there is
more feedback and repost a v3 addressing all the issues you pointed out.

Best regards,
Javier
