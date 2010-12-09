From: cyril@ti.com (Cyril Chemparathy)
Date: Thu, 09 Dec 2010 09:58:41 -0500
Subject: [PATCH v7 11/12] davinci: add tnetv107x evm backlight device
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930247CD84F4@dbde02.ent.ti.com>
References: <1291733522-3626-1-git-send-email-cyril@ti.com>	<1291733522-3626-12-git-send-email-cyril@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247CD83E1@dbde02.ent.ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247CD84F4@dbde02.ent.ti.com>
Message-ID: <4D00EEA1.8070201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2010 06:00 AM, Nori, Sekhar wrote:
> On Thu, Dec 09, 2010 at 14:25:49, Nori, Sekhar wrote:
> 
>> This call should simply return if machine is not tnetv107x EVM.
>>
>> I didn't follow the entire series but wondering why
>> platform device registration should be a late init call.
>> Typically the driver probe can be made a late init call
>> in case of init sequence dependencies.
> 
> I meant driver init, not probe.

This was done to handle driver dependencies, and is meant to be
temporary (until a real driver dependency framework comes in).

Please see [1] for a bit more of background on changing drivers to use
module_init().

Regards
- Cyril.

[1]
http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2010-November/020987.html
