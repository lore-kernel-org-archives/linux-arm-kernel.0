From: richard.genoud@gmail.com (Richard Genoud)
Date: Thu, 2 May 2013 10:12:03 +0200
Subject: [PATCH v6 01/16] spi/spi-atmel: fix probing failure after
 xfer->speed_hz set
In-Reply-To: <B256D81BAE5131468A838E5D7A24364154236AB5@penmbx02>
References: <1362626715-6549-1-git-send-email-wenyou.yang@atmel.com>
 <1362626815-6628-1-git-send-email-wenyou.yang@atmel.com>
 <CAGhQ9VwW18LXY5Jn0FUFCaAzKxP1W3QADG=JBp9JbgaAwo=F2Q@mail.gmail.com>
 <B256D81BAE5131468A838E5D7A24364154236AB5@penmbx02>
Message-ID: <CACQ1gAhZO3stjrwf5SiZf7jOO8T5bAJZiz97M7+7vwFmk2e65g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/5/2 Yang, Wenyou <Wenyou.Yang@atmel.com>:
> Hi, Joachim,
>
>> -----Original Message-----
>> From: Joachim Eastwood [mailto:manabian at gmail.com]
>> Sent: 2013?3?7? 20:31
>> To: Yang, Wenyou
>> Cc: linux-arm-kernel at lists.infradead.org; grant.likely at secretlab.ca; Ferre,
>> Nicolas; plagnioj at jcrosoft.com; richard.genoud at gmail.com; Lin, JM;
>> spi-devel-general at lists.sourceforge.net; linux-kernel at vger.kernel.org
>> Subject: Re: [PATCH v6 01/16] spi/spi-atmel: fix probing failure after
>> xfer->speed_hz set
>>
>> On 7 March 2013 04:26, Wenyou Yang <wenyou.yang@atmel.com> wrote:
>> > commit: 059b8ffeee5b427949872bb6ed5db5ae0788054e
>> > cause the atmel spi probing failure.
>> >
>> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
>> > Cc: spi-devel-general at lists.sourceforge.net
>> > Cc: linux-kernel at vger.kernel.org
>> > ---
>> >  drivers/spi/spi-atmel.c |    6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
>> > index 656d137..1eca815 100644
>> > --- a/drivers/spi/spi-atmel.c
>> > +++ b/drivers/spi/spi-atmel.c
>> > @@ -846,9 +846,9 @@ static int atmel_spi_transfer(struct spi_device *spi,
>> struct spi_message *msg)
>> >                         }
>> >                 }
>> >
>> > -               /* FIXME implement these protocol options!! */
>> > -               if (xfer->speed_hz) {
>> > -                       dev_dbg(&spi->dev, "no protocol options
>> yet\n");
>> > +               if (xfer->speed_hz < spi->max_speed_hz) {
>> > +                       dev_dbg(&spi->dev,
>> > +                               "speed in transfer less than bus
>> speed\n");
>> >                         return -ENOPROTOOPT;
>> >                 }
>>
>> I sent a similar patch to spi-devl a while ago, which Grant said he applied.
>> https://patchwork.kernel.org/patch/2165301/
>>
>> Can't find the patch in any upstream git tree so I guess Grant hasn't
>> pushed it yet.
> This patch hasn't still applied in any upstream git tree, so Atmel spi master doesn't work.
> Could you help do some ping it?

it's in linux-next:
3d3522604a5557e80fdcab61c54bd04eaf15b525
merged from spi-current/spi/merge


Richard.
