From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 1 Oct 2010 12:37:57 +0200
Subject: [PATCH] spi/pl022: make sure the chip_info dev pointer is set
In-Reply-To: <AANLkTimZXF-ntBSROV2pVN+Td1Bek7C5DtKZTQgXY=Wt@mail.gmail.com>
References: <1285839648-7368-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTimZXF-ntBSROV2pVN+Td1Bek7C5DtKZTQgXY=Wt@mail.gmail.com>
Message-ID: <4CA5BA05.3000605@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote:

>>        } else {
>> +               /* Users should not set this field */
>> +               chip_info->dev = &spi->dev;
>>                dev_dbg(&spi->dev,
>>                        "using user supplied controller_data settings\n");
>>        }
> 
> Nack.  data passed to a driver via the controller_data must be
> immutable as far as the device driver is concerned.

I posted another patch removing it instead, that's obviously the
right thing to do...

Yours,
Linus Walleij
