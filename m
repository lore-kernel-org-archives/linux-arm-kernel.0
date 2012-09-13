From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Sep 2012 19:15:55 -0600
Subject: [PATCH V3 5/5] ARM: bcm2708: instantiate console UART
In-Reply-To: <201209121045.39999.arnd@arndb.de>
References: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
 <1347423509-30647-5-git-send-email-swarren@wwwdotorg.org>
 <201209121045.39999.arnd@arndb.de>
Message-ID: <505133CB.1060906@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2012 04:45 AM, Arnd Bergmann wrote:
> On Wednesday 12 September 2012, Stephen Warren wrote:
>> From: Simon Arlott <simon@fire.lp0.eu>
>>
>> This patch was extracted from git://github.com/lp0/linux.git branch
>> rpi-split as of 2012/09/08, and modified as follows:
>>
>> * Modified UART DT node to use a unit-address to differentiate UART node
>>   names, rather than using different base names "uart0" and "uart1".
>>   Note that UART 1 (the Broadcom "mini UART") is not yet present, but
>>   I'm naming the DT node in anticipation that it will be added.
>>
> 
> Shouldn't the selection be done using an alias like this?
> 
> 	aliases {
> 		serial0 = &/uart at 20201000;
> 	};

The "differentiate" was more "ensure that node names in DT are unique"
than anything to do with user-visible selection/identification.

I can certainly add the alias if you want, but I don't know what benefit
it will have, since I've never used aliases before.
