From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Thu, 30 Aug 2012 16:17:14 +0000
Subject: [PATCH] arm:davinci: clk - migrate to new common clock API
In-Reply-To: <5029F079.8010901@ti.com>
References: <1343926428-5210-1-git-send-email-m-karicheri2@ti.com>
 <5029F079.8010901@ti.com>
Message-ID: <3E54258959B69E4282D79E01AB1F32B7041AD30F@DFLE12.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Agreed. So I am not re-sending this patch.

Murali Karicheri
Software Design Engineer


>> -----Original Message-----
>> From: Nori, Sekhar
>> Sent: Tuesday, August 14, 2012 2:30 AM
>> To: Karicheri, Muralidharan
>> Cc: linux-arm-kernel at lists.infradead.org; davinci-linux-open-
>> source at linux.davincidsp.com; linux-keystone at list.ti.com - Linux developers for Keystone
>> family of devices (May contain non-TIers); Turquette, Mike; Chemparathy, Cyril;
>> linux at arm.linux.org.uk
>> Subject: Re: [PATCH] arm:davinci: clk - migrate to new common clock API
>> 
>> 
>> Hi Murali,
>> 
>> On 8/2/2012 10:23 PM, Murali Karicheri wrote:
>> > As a first step towards migrating davinci platforms to use common clock
>> > framework, replace all instances of clk_enable() with clk_prepare_enable()
>> > and clk_disable() with clk_disable_unprepare(). Until the platform is
>> > switched to use the CONFIG_HAVE_CLK_PREPARE Kconfig variable, this just
>> > adds a might_sleep() call and would work without any issues.
>> >
>> > This will make it easy later to switch to common clk based implementation
>> > of clk driver from DaVinci specific driver.
>> >
>> > Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> 
>> Queuing this patch for v3.7. The subject line should have ARM in
>> capitals for consistency. Also, you are not really migrating to new API
>> in this patch - just preparing for migration so I prefer:
>> 
>> "ARM: davinci: convert platform code to use clk_prepare/clk_unprepare"
>> 
>> I will make this change while committing.
>> 
>> Thanks,
>> Sekhar
