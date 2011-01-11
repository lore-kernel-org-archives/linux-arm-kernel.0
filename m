From: nm@ti.com (Nishanth Menon)
Date: Tue, 11 Jan 2011 17:55:03 -0600
Subject: [PATCH v5 3/3] omap3: beaglexm: fix power on of DVI
In-Reply-To: <20110111232329.GY4957@atomide.com>
References: <1294766017-12182-4-git-send-email-nm@ti.com>
	<20110111232329.GY4957@atomide.com>
Message-ID: <4D2CEDD7.4020507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren had written, on 01/11/2011 05:23 PM, the following:
[..]
>> -
>> -	gpio_request(gpio + 1, "EHCI_nOC");
>> -	gpio_direction_input(gpio + 1);
>> +	if (omap3_beagle_get_rev() != OMAP3BEAGLE_BOARD_XM) {
>> +		gpio_request(gpio + 1, "EHCI_nOC");
>> +		gpio_direction_input(gpio + 1);
>> +	}
> 
> The return value for gpio_request must be checked.
Ack.
we can go down two paths:
a) I can redo this patch as in v6.patch (attached)
OR
b) we take this patch and do another one cleaning the function up - 
gpio-check.patch

-- 
Regards,
Nishanth Menon
