From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 2 Jan 2017 13:13:24 -0300
Subject: [PATCH] crypto: picoxcell - Fix module autoload for non-OF
 registration
In-Reply-To: <2761495.aqgObxUbGB@wuerfel>
References: <1483371482-4956-1-git-send-email-javier@osg.samsung.com>
 <2761495.aqgObxUbGB@wuerfel>
Message-ID: <ab87e239-6623-764b-998d-3d8148a6adf1@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On 01/02/2017 01:05 PM, Arnd Bergmann wrote:
> On Monday, January 2, 2017 12:38:02 PM CET Javier Martinez Canillas wrote:
>> If the driver is built as a module, autoload won't work because the module
>> alias information is not filled. So user-space can't match the registered
>> device with the corresponding module if the device isn't registered via OF.
>>
>> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
> 
> I think we can just remove the table, as the platform only supports
> booting through DT anyway.
> 

Agreed. I should had checked if mach-picoxcell was DT-only indeed.

Should I also make the driver to depend on OF and remove the #ifdefery then?

> 	Arnd
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
