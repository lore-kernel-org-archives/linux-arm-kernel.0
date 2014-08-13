From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 13 Aug 2014 15:34:12 +0200
Subject: [PATCH 6/6] ARM: dts: Add tps65090 FETs constraints
In-Reply-To: <20140813122910.GQ17528@sirena.org.uk>
References: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
 <1407861868-20097-7-git-send-email-javier.martinez@collabora.co.uk>
 <20140812172552.GU17528@sirena.org.uk> <53EA61B9.2070805@collabora.co.uk>
 <20140812212757.GY17528@sirena.org.uk> <53EB4CA0.3010006@collabora.co.uk>
 <20140813122910.GQ17528@sirena.org.uk>
Message-ID: <53EB6954.3040207@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2014 02:29 PM, Mark Brown wrote:
> 
> Please fix your mailer to word wrap at less than 80 columns, it makes
> your mails very hard to read when replying.
> 

Sorry I had my wrap length configured to 80 but just changed to 74 now.

>> On 08/12/2014 11:27 PM, Mark Brown wrote:
> 
> No, that makes no sense.  If the voltage isn't allowed to change why
> should the constraints be specifying a range of voltages for it to be
> set to, especially a range with more than one value in it?
> 
> Please try to think about what you're doing in design terms rather than
> just bashing on things until you get something that works in your use
> case, it's important that things are understandable so that we avoid
> fragility and special casing.
> 
>> For fixed regulators (like fet4), mmc_regulator_set_ocr() just skips >> varying the regulator voltage but still expects to be able to obtain
>> its voltage.
> 
> Which can be done with regulator_get_voltage().
> 

Indeed. I'll change mmc_regulator_get_ocrmask() in MMC core then to use
regulator_can_change_voltage() to detect if the regulator is a fixed one
and call regulator_get_voltage() instead of list_voltage() in that case.

Do you agree that this is the correct solution?

Best regards,
Javier
