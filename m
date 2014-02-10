From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 10 Feb 2014 13:58:00 +0100
Subject: [GIT PULL] at91: fixes for 3.14 #1
In-Reply-To: <20140207172055.GC9558@ns203013.ovh.net>
References: <1391790986-31936-1-git-send-email-nicolas.ferre@atmel.com>
 <20140207172055.GC9558@ns203013.ovh.net>
Message-ID: <52F8CCD8.3070409@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2014 18:20, Jean-Christophe PLAGNIOL-VILLARD :
> On 17:36 Fri 07 Feb     , Nicolas Ferre wrote:
>> Arnd, Olof, Kevin,
>>
>> This is a first "fixes" series for AT91 on 3.14.
>> The content is only DT-related and quite boring.
>> I took the opportunity of this early "fixes" pull-request to collect
>> some Documentation patches that were lying around and I guess that
>> they can be merged by arm-soc nicely (addition of CCF to 2 drivers).
>> A new board is added to the lot because it is dead simple and integrates
>> well with the new sama5d36 SoC that we added earlier in this development cycle.
>>
>> Thanks, best regards,
>>
>> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
>>
>>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
>>
>> are available in the git repository at:
>>
>>   git://github.com/at91linux/linux-at91.git tags/at91-fixes
>>
>> for you to fetch changes up to b7c2b6157079811586180d13c44a1095b57c2d47:
>>
>>   ARM: at91: add Atmel's SAMA5D3 Xplained board (2014-02-07 17:20:39 +0100)
>>
>> ----------------------------------------------------------------
>> First series of AT91 fixes for 3.14.
>> All of them are DT-related.
>> - fixes for typos in i2c and ohci clocks
>> - addition of a USB host node for at91sam9n12ek
>> - 2 DT documentation updates that have been sent a long time ago
>> - a new board based on the sama5d36 SoC
>>
>> ----------------------------------------------------------------
>> Bo Shen (1):
>>       ARM: at91: enable USB host on at91sam9n12ek board
>>
>> Boris BREZILLON (3):
>>       ARM: at91/dt: fix sama5d3 ohci hclk clock reference
>>       mmc: atmel-mci: document clock properties
>>       spi/atmel: document clock properties
>>
>> Jean-Jacques Hiblot (1):
>>       ARM: at91/dt: sam9263: fix compatibility string for the I2C
>>
>> Nicolas Ferre (1):
>>       ARM: at91: add Atmel's SAMA5D3 Xplained board
> 
> still comment on it please drop it on the PULL

No, please don't.

I wrote this pull-request after having considered Jean-Christophe's
comments and having corrected my initial DTS file.
The comments that Jean-Christophe made in addition to the patch included
in this pull-request are just his point of view that I don't share (and
I've just answered his email BTW).

Jean-Christophe, I tend to ask for code inclusion when I am sure that
the content is ready and don't build a pull-request lightly. So please
do not add fuzziness to the AT91 maintenance process.

That said, I do not plan to put pressure on anybody. I just thought that
this board was simple enough so that it can seamlessly integrate 3.14...

Bye,

>>  .../devicetree/bindings/mmc/atmel-hsmci.txt        |   5 +
>>  .../devicetree/bindings/spi/spi_atmel.txt          |   5 +
>>  arch/arm/boot/dts/Makefile                         |   1 +
>>  arch/arm/boot/dts/at91-sama5d3_xplained.dts        | 229 +++++++++++++++++++++
>>  arch/arm/boot/dts/at91sam9263.dtsi                 |   2 +-
>>  arch/arm/boot/dts/at91sam9n12ek.dts                |   4 +
>>  arch/arm/boot/dts/sama5d3.dtsi                     |   2 +-
>>  7 files changed, 246 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/at91-sama5d3_xplained.dts
>>
>> -- 
>> Nicolas Ferre
> 


-- 
Nicolas Ferre
