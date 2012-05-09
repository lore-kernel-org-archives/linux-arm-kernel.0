From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 9 May 2012 16:01:15 +0530
Subject: [PATCH 07/10] spi: s3c64xx: Remove the 'set_level' callback from
 controller data
In-Reply-To: <201205091120.41978.heiko@sntech.de>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-8-git-send-email-thomas.abraham@linaro.org>
 <201205091120.41978.heiko@sntech.de>
Message-ID: <CAJe_ZhczJhGxUTgdD57n_R7Nz8oD6a075LMzjcejO6QkrHTXTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 May 2012 14:50, Heiko St?bner <heiko@sntech.de> wrote:
> Am Mittwoch, 9. Mai 2012, 00:04:51 schrieb Thomas Abraham:
>> The set_level callback in the controller data, which is used to configure
>> the slave select line, cannot be supported when migrating the driver to
>> device tree based discovery. Since all the platforms currently use gpio
>> as the slave select line, this callback can be removed from the
>> controller data and replaced with call to gpio_set_value in the driver.
>
> I was quite fond of the set_level callback. On one of the machines I'm working
> on there is some sort of multiplexer (TI-sn74cbtlv3257) sitting between the
> controller and spi devices to provide support for more than one device.
> So I was doing the switch to the correct device in the set_level callback,
> which worked quite well.
>
I suppose you should still be able to do that defining virtual gpios backed
by appropriate physical mux'ing of lines ?

-jassi
