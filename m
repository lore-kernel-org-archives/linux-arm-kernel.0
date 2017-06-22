From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 22 Jun 2017 15:48:33 +0800
Subject: [PATCH 2/2] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
In-Reply-To: <20170620074126.GA1541@katana>
References: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
 <1495947576-11037-3-git-send-email-shawnguo@kernel.org>
 <20170619193130.velebm7p3r5ggaos@ninjato>
 <20170620025815.GA4818@x250> <20170620074126.GA1541@katana>
Message-ID: <20170622074831.GA23753@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 09:41:26AM +0200, Wolfram Sang wrote:
> > > How was this driver tested BTW?
> > 
> > The driver is being used to access an Audio codec on the I2C bus.
> 
> Nice. Can you also run 'i2cdetect' on the bus to see if we have proper
> NAK handling? AFAICS this should be broken now. And very slow with
> previous versions of the driver.

Hmm, it seems that 'i2cdetect' works fine with the driver.

$ i2cdetect -l
i2c-0   i2c             zx2967 i2c adapter                      I2C adapter
$ i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] Y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- UU -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- -- 
50: -- -- -- -- -- -- -- -- -- -- 5a -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: 70 -- -- -- -- -- -- --                         
$

The audio codec is on address 0x22.

Why do you think it should be broken now?

Shawn
