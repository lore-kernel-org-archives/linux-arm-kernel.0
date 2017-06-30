From: aravind.thk@gmail.com (Aravind Thokala)
Date: Fri, 30 Jun 2017 23:08:15 +0530
Subject: [PATCH] spi/bcm63xx-hspi: Fix checkpatch warnings
In-Reply-To: <20170628184507.tnl7jc4wvtt5op5q@sirena.org.uk>
References: <1498579630-10109-1-git-send-email-aravind.thk@gmail.com>
 <20170628184507.tnl7jc4wvtt5op5q@sirena.org.uk>
Message-ID: <CAAUiYHf6n+C9Q7TdApG_7mOdc7fJyTKq9To=4PvgXARQ5eOAOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

Thank you for reviewing the patch. I've used the checkpatch tool and
fixed the warnings provided by the tool. The warnings are in the
function definitions:

1) static void bcm63xx_hsspi_set_cs(struct bcm63xx_hsspi *bs, unsigned
 cs, bool active)

2) static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi *bs,
                                  struct spi_device *spi, int hz)
{
        unsigned profile = spi->chip_select;

3) static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct
spi_transfer *t)
{
        struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
        unsigned chip_select = spi->chip_select;

These warnings looked straightforward for me so I've fixed those and
sent the patch.

Kindly let me know if you want to record the warnings in the patch so
that I could send v2 patch as soon as possible.

Thank you,

Aravind.


On 29 June 2017 at 00:15, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jun 27, 2017 at 09:37:10PM +0530, Aravind Thokala wrote:
>> This patch fixes the checkpatch.pl warnings on the driver
>> file.
>
> This isn't a good changelog, what are the warnings and why are we fixing
> them?  The fact that checkpatch complains isn't meaningful in and of
> itself - it's OK to say that checkpatch helped identify issues but it's
> not perfect and we need to understand what is being changed and why.
