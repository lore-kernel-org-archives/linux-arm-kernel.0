From: thommycheck@gmx.de (Thomas Kunze)
Date: Wed, 07 Oct 2009 22:23:14 +0200
Subject: [PATCH 2/9] collie: prepare for gpiolib use
In-Reply-To: <20091007110805.GA7656@rainbow>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-2-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-3-git-send-email-thommycheck@gmx.de>
	<20091007110805.GA7656@rainbow>
Message-ID: <4ACCF8B2.7020907@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Artamonow wrote:
> On 23:35 Mon 05 Oct     , Thomas Kunze wrote:
>   
>> prefix gpio definitions for direct register access with '_' so we
>> can use the other names for gpio_request & co
>>     
>
> Familiar problem - numeric vs bit-shifted gpio defines.
> I'm facing it here too while converting h3[16]00 to gpiolib,
> and I'm thinking about dropping bit-shifted defines completely
> and using GPIO_GPIO(SOME_NUMERIC_GPIO) instead.
>
> Perhaps you may find this idea useful for collie.
>
>   
While a good idea I don't want to make the line in cpu initialisation 
any longer.
This is only a short term solution. In the long term we should do the 
same as pxa.
