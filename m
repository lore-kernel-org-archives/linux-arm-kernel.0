From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 06 Oct 2010 15:22:04 +0200
Subject: [PATCH for 2.6.36 2/2] cpuimx27: fix i2c bus selection
In-Reply-To: <20101006130704.GJ29673@pengutronix.de>
References: <1286355230-15530-1-git-send-email-eric@eukrea.com>
	<1286355230-15530-2-git-send-email-eric@eukrea.com>
	<20101006130704.GJ29673@pengutronix.de>
Message-ID: <4CAC77FC.6080908@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 06/10/2010 15:07, Uwe Kleine-K?nig a ?crit :
> On Wed, Oct 06, 2010 at 10:53:50AM +0200, Eric B?nard wrote:
>> Recent clean of i.MX devices registration changed the i2C bus number
>> selected for our platform (Freescale start peripheral ID at 1, kernel
>> now start it at 0 so i.MX27's i2c 1 is kernel's i2c 0).
>> Without this fix, i2c is unusable on this platform.
>>
>> Signed-off-by: Eric B?nard<eric@eukrea.com>
>> ---
>>   arch/arm/mach-imx/mach-cpuimx27.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
>> index 339150a..6830afd 100644
>> --- a/arch/arm/mach-imx/mach-cpuimx27.c
>> +++ b/arch/arm/mach-imx/mach-cpuimx27.c
>> @@ -259,7 +259,7 @@ static void __init eukrea_cpuimx27_init(void)
>>   	i2c_register_board_info(0, eukrea_cpuimx27_i2c_devices,
>>   				ARRAY_SIZE(eukrea_cpuimx27_i2c_devices));
>>
>> -	imx27_add_i2c_imx1(&cpuimx27_i2c1_data);
>> +	imx27_add_i2c_imx0(&cpuimx27_i2c1_data);
> This doesn't fit on Sascha's current tree.  Can you please rebase it?
>
against which branch ?

Eric
