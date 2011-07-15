From: dv@vollmann.ch (Detlef Vollmann)
Date: Fri, 15 Jul 2011 18:44:45 +0200
Subject: [PATCH 4/7] at91: remove non used at91_spi.h
In-Reply-To: <20110715154636.GA20678@game.jcrosoft.org>
References: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
	<1310687525-22486-4-git-send-email-plagnioj@jcrosoft.com>
	<4E2028E1.1060603@vollmann.ch>
	<20110715154636.GA20678@game.jcrosoft.org>
Message-ID: <4E206E7D.2070708@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/11 17:46, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 13:47 Fri 15 Jul     , Detlef Vollmann wrote:
>> Sorry, I couldn't find a summary message for this patch series,
>> so I picked this one to reply, because this one hurts me most.
>>
>> On 07/15/11 01:52, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
>>> Cc: Nicolas Ferre<nicolas.ferre@atmel.com>
>>> ---
>>>    arch/arm/mach-at91/include/mach/at91_spi.h |   81
>> ----------------------------
>>>    1 files changed, 0 insertions(+), 81 deletions(-)
>>>    delete mode 100644 arch/arm/mach-at91/include/mach/at91_spi.h
>> [...]
>>
>> First, I'm actually using mach/at91_spi.h in an SPI slave driver.
>> And I'm using arch/arm/mach-at91/include/mach/at91_spi.h instead of
>> drivers/spi/atmel_spi.h (which still exists in the kernel version
>> we use here), because arch/arm/mach-at91/include/mach/at91_spi.h
>> is accessible from an out-of-tree driver w/o extra effort.
>>
>> And this applies to all all of those header files, so I'm
>> really against all patches in this series.
> You need the use SPI framework for this
I think you reply here to the wrong part of my message.
This part here is about the whole patch series, as I didn't
get a summary message for the patch series.

About the SPI driver:
 From Documentation/spi/spi-summary:
"At this writing, Linux has no slave side programming interface."
So there's no SPI framwork that covers the slave side.

> Out of tree driver is not enough good reason to keep it
As there's currently no slave support in-tree, any Linux device
that's an SPI slave needs an out-of-tree driver.

And again, there's no rationale given for moving all the other
headers from an genarally accessible place to a generally
inaccessible place, so I'm still against the whole patch series.

Regards,
   Detlef
