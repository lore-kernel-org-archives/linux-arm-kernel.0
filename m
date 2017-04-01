From: rafal@milecki.pl (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sat, 1 Apr 2017 23:41:08 +0200
Subject: [PATCH V4 2/2] thermal: broadcom: add Northstar thermal driver
In-Reply-To: <20170401195443.GE28514@localhost.localdomain>
References: <20170331073132.21457-2-zajec5@gmail.com>
 <20170331201124.656-1-zajec5@gmail.com>
 <20170331201124.656-2-zajec5@gmail.com>
 <20170401195443.GE28514@localhost.localdomain>
Message-ID: <426f06c2-e972-a9b0-e72c-88e7dde991ed@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2017 09:54 PM, Eduardo Valentin wrote:
> On Fri, Mar 31, 2017 at 10:11:24PM +0200, Rafa? Mi?ecki wrote:
>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>
>> Northstar is a SoC family commonly used in home routers. This commit
>> adds a driver for checking CPU temperature. As Northstar Plus seems to
>> also have this IP block this new symbol gets ARCH_BCM_IPROC dependency.
>>
>> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
>> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
>> ---
>
> This driver looks fine from what concerns the of thermal usage.
> I had only one request on the DT bindings example. I believe better to
> get the example fixed so bad DTs does not get copied.

Thanks! I'll comment on this in a reply to patch 1/2.


>> V2: Make it iProc specific as NSP can also use this driver
>>     Select proper symbols in config ARCH_BCM_IPROC
>>     Define PVTMON register bits
>>     Update code selecting temperature monitor mode
>>     Thank you Jon!
>> V3: More details in help message for BCM_NS_THERMAL
>>     Use slope & offset
>>     Drop arch code change (I'll be submitted using a proper tree)
>>     Thank you Eduardo!
>> V4: Comment operations on PVTMON_CONTROL0 register
>> ---
>>  drivers/thermal/Kconfig               |   5 ++
>>  drivers/thermal/Makefile              |   1 +
>>  drivers/thermal/broadcom/Kconfig      |   8 +++
>>  drivers/thermal/broadcom/Makefile     |   1 +
>>  drivers/thermal/broadcom/ns-thermal.c | 105 ++++++++++++++++++++++++++++++++++
>
> Also, I have just merged a BRCM driver. Does it make sense to move it
> here too?
>
> It does not need to be a blocking request for this driver though.

Yes, I plan to send a patch for that after getting this one accepted.
