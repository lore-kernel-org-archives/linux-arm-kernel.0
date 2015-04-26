From: hramrach@gmail.com (Michal Suchanek)
Date: Sun, 26 Apr 2015 13:42:51 +0200
Subject: [PATCH 3/3] ARM: sunxi: spi: use proper errno when message is too
 long.
In-Reply-To: <20150426084221.GE5627@lukather>
References: <cover.1430034797.git.hramrach@gmail.com>
 <4c27d44b2bdd759424ce4a4b2e8f6abf5d5a6735.1430034797.git.hramrach@gmail.com>
 <20150426084221.GE5627@lukather>
Message-ID: <CAOMqctS3oXd5Wg7vu6xLtA6gDKgY0c9rHER48Grt7tnw53Zo1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 April 2015 at 10:42, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Apr 25, 2015 at 09:21:07PM +0200, Michal Suchanek wrote:
>> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>
> No commit log?
>
>> ---
>>  drivers/spi/spi-sun4i.c | 2 +-
>>  drivers/spi/spi-sun6i.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
>> index fbb0a4d..8238b4e 100644
>> --- a/drivers/spi/spi-sun4i.c
>> +++ b/drivers/spi/spi-sun4i.c
>> @@ -176,7 +176,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>>
>>       /* We don't support transfer larger than the FIFO */
>>       if (tfr->len > SUN4I_FIFO_DEPTH)
>> -             return -EINVAL;
>> +             return -EMSGSIZE;
>
> Is it still a thing? The patch to remove such limit hasn't been merged
> yet?

Yes, seems so unless the patches are queued somewhere but not merged yet.

>
>>       reinit_completion(&sspi->done);
>>       sspi->tx_buf = tfr->tx_buf;
>> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
>> index ac48f59..0f5dd91 100644
>> --- a/drivers/spi/spi-sun6i.c
>> +++ b/drivers/spi/spi-sun6i.c
>> @@ -166,7 +166,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
>>
>>       /* We don't support transfer larger than the FIFO */
>>       if (tfr->len > SUN6I_FIFO_DEPTH)
>> -             return -EINVAL;
>> +             return -EMSGSIZE;
>
> Eventually, we should move to using DMA for these messages longer than
> the FIFO.
>
> I should post these patches.
>

Do you have those in a branch somewhere?

Thanks

Michal
