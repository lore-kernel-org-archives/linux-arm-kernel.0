From: fisaksen@baylibre.com (Frode Isaksen)
Date: Fri, 17 Feb 2017 17:43:31 +0100
Subject: [PATCH v2 5/6] spi: davinci: do not use DMA if transfer length is
 less than 16
In-Reply-To: <CAK8P3a24HkxrU-6a727RY5JqwQgyf9SpprPXvurSqf1Q_W_AMQ@mail.gmail.com>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
 <1487327904-28311-6-git-send-email-fisaksen@baylibre.com>
 <CAK8P3a24HkxrU-6a727RY5JqwQgyf9SpprPXvurSqf1Q_W_AMQ@mail.gmail.com>
Message-ID: <3358b5f1-c7b6-0955-0c36-6f135a585762@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/02/2017 17:37, Arnd Bergmann wrote:
> On Fri, Feb 17, 2017 at 11:38 AM, Frode Isaksen <fisaksen@baylibre.com> wrote:
>> Higher bitrate and lower CPU load if using PIO in this case.
>>
>> Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
>> ---
>>  drivers/spi/spi-davinci.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
>> index b69a370..826bff1 100644
>> --- a/drivers/spi/spi-davinci.c
>> +++ b/drivers/spi/spi-davinci.c
>> @@ -110,6 +110,8 @@
>>  #define SPIDEF         0x4c
>>  #define SPIFMT0                0x50
>>
>> +#define DMA_MIN_BYTES  16
> 16 seems low as the cutoff. Have you found this experimentally and
> tested that for e.g. 32
> bytes there is actually an advantage in using DMA?
Yes, I have tested for different sizes. Actually 32 bytes is better @30MHz, but if the bit rate goes down, DMA wins over PIO. Do you prefer 32 bytes ?

Frode
>
>     Arnd
