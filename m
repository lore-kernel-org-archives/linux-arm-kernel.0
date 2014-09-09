From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 9 Sep 2014 14:20:27 -0400
Subject: [PATCH v2] spi: davinci: add support for adding delay between
 word's transmission
In-Reply-To: <20140909172057.GH2601@sirena.org.uk>
References: <1410278851-10783-1-git-send-email-grygorii.strashko@ti.com>
 <20140909165555.GD2601@sirena.org.uk> <540F3447.3020609@ti.com>
 <20140909172057.GH2601@sirena.org.uk>
Message-ID: <540F44EB.8090700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2014 01:20 PM, Mark Brown wrote:
> On Tue, Sep 09, 2014 at 01:09:27PM -0400, Murali Karicheri wrote:
>> On 09/09/2014 12:55 PM, Mark Brown wrote:
>>> On Tue, Sep 09, 2014 at 07:07:31PM +0300, Grygorii Strashko wrote:
>
>>>> - ti,spi-c2t-delay: Chip-select-active-to-transmit-start delay
>>>> 	(SPIDELAY.C2TDELAY)
>
>>>> - ti,spi-t2c-delay: Transmit-end-to-chip-select-inactive delay
>>>> 	(SPIDELAY.T2CDELAY)
>
>>> Now I look at these they look very much like the standard delay feature
>>> that the SPI subsystem has already - are they?
>
>> As Grygorii explained in previous postings (reproduced below), these delays
>> are handled by the SPI hardware on Keystone and affect the delay between
>> successive word tranmssion and has nothing to do with the delay you are
>> talking about. Isn't the standard delay you mention here is between
>> successive packets send down to the lower level driver (in this case
>> spi-davinci.c) ?
>
> He talked about such delays between words (and there were some other
> delays listed which seemed to meet that description) but the above don't
> appear to refer to them, the above refer to delays around chip select
> which most definitely are covered with the standard delays.
>
> If these delays are not related to chip select then the documentation
> needs to be fixed to not refer to chip select.

Ok. So what I understand is the issue is not having the right 
description to indicate that these parameters are delays associated with 
tranmission of successive words on the wire. Personally I like these 
description match with what is described in the device spec/ user guide 
and what is described above match with that. However we could add 
additional description as below to to make it more explicit.

spi-c2t-delay - delay after CS is asserted before output bits on wire
spi-t2c-delay - delay after tramission of bits and before deasserting CS
wdelay - delay between successive word transmission.

Do you think this will help?

Murali
