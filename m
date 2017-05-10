From: linux@rempel-privat.de (Oleksij Rempel)
Date: Wed, 10 May 2017 06:47:58 +0200
Subject: [PATCH v3] arm: dts: sun7i-a20-bananapi: name the GPIO lines
In-Reply-To: <20170509202725.e2tkry7dmsgx7se5@lukather>
References: <1494048638-24365-1-git-send-email-linux@rempel-privat.de>
 <20170509202725.e2tkry7dmsgx7se5@lukather>
Message-ID: <17553199-cc74-96ae-bc75-5e91b866ccd1@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.05.2017 um 22:27 schrieb Maxime Ripard:
> Hi Oleksij,
> 
> It looks much better, thanks!
> 
> On Sat, May 06, 2017 at 07:30:38AM +0200, Oleksij Rempel wrote:
>> This names the GPIO lines on the Banana Pi board in accordance with
>> the A20_Banana_Pi v1.4 Specification.
>>
>> This will make these line names reflect through to user space
>> so that they can easily be identified and used with the new
>> character device ABI.
>>
>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: devicetree at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: Chen-Yu Tsai <wens@csie.org>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
> 
> Usually, it's better here if you put a change log with the things that
> changed from one version to another.
> 
> You probably remember all of the comments that were made on the
> previous version of that patch, but I don't ;)

ok.

> 
>>  arch/arm/boot/dts/sun7i-a20-bananapi.dts | 51 ++++++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
>> index 91f2e5f..6b326b3 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
>> @@ -178,6 +178,57 @@
>>  };
>>  
>>  &pio {
>> +	gpio-line-names =
>> +		/* PA */
>> +		"ERXD3", "ERXD2", "ERXD1", "ERXD0", "ETXD3",
>> +			"ETXD2", "ETXD1", "ETXD0",
>> +		"ERXCK", "ERXERR", "ERXDV", "EMDC", "EMDIO",
>> +			"ETXEN", "ETXCK", "ECRS",
>> +		"ECOL", "ETXERR", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		/* PB */
>> +		"PMU-SCK", "PMU-SDA", "", "", "", "", "", "",
>> +		"", "USB0-DRV", "", "", "", "", "", "",
>> +		"", "", "", "", "SCL", "SDA", "", "",
> 
> I'm not sure how it's called in the schematics / documentation, but
> having a way to get which bus it's from would be helpful (like you did
> for the PMIC I2C bus).

I use only names provided by schematics. Using something different IMO
makes no sense and confusing.

>> +		"", "", "", "", "", "", "", "",
>> +		/* PC */
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		/* PD */
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		/* PE */
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		/* PF */
>> +		"SD0-D1", "SD0-D0", "SD0-CLK", "SD0-CMD", "SD0-D3",
>> +			"SD0-D2", "", "",
> 
> Why did you change the wrapping and indentation on those two lines?

i use 8 entry per line to keep counting easier. If line is too wide, i
wrap it with changed indentation.

>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		/* PG */
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "",
>> +		/* PH */
>> +		"TXD0", "RXD0", "IO-1", "PH3", "USB0-IDDET", "PH5", "", "",
> 
> What are PH3 and PH5 used for on the board? Can't we provide a more
> explicit name?

Only names used by schematic :) If we will use something different users
will hate us even more.

I can image to use some kind of combination of connector name and pin
name. For example: "JP1-RXD0", or some thing like this.

> Thanks!
> Maxime
> 


-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170510/ef46205f/attachment.sig>
