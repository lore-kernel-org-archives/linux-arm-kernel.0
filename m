From: girishks2000@gmail.com (Girish KS)
Date: Wed, 24 Apr 2013 15:09:38 +0530
Subject: [PATCH 2/3] spi: s3c64xx: Added provision for dedicated cs pin
In-Reply-To: <20130423144256.GP5019@opensource.wolfsonmicro.com>
References: <1366614565-3743-1-git-send-email-ks.giri@samsung.com>
 <1366614565-3743-3-git-send-email-ks.giri@samsung.com>
 <20130423144256.GP5019@opensource.wolfsonmicro.com>
Message-ID: <CAKrE-KdJZHzVH-0sRkP2hyPBcn9CMiqgQBcrZTap6zwVuAhZLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 8:12 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Apr 22, 2013 at 12:39:24PM +0530, Girish K S wrote:
>> From: Girish K S <girishks2000@gmail.com>
>>
>> The existing driver supports gpio based /cs signal.
>> For controller's that have one device per controller,
>> the slave device's /cs signal might be internally controlled
>> by the chip select bit of slave select register. They are not
>> externally asserted/deasserted using gpio pin.
>
> This doesn't build:
>
> drivers/spi/spi-s3c64xx.c: In function 's3c64xx_get_slave_ctrldata':
> drivers/spi/spi-s3c64xx.c:1023: error: 'sdd' undeclared (first use in this function)
> drivers/spi/spi-s3c64xx.c:1023: error: (Each undeclared identifier is reported only once
> drivers/spi/spi-s3c64xx.c:1023: error: for each function it appears in.)

Ohhhhhh. Sorry. forgot to commit the changes before patch generation
