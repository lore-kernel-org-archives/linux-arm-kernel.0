From: javier.martin@vista-silicon.com (javier Martin)
Date: Thu, 28 Feb 2013 15:08:13 +0100
Subject: [PATCH v2 2/3] crypto: sahara: Add driver for SAHARA2 accelerator.
In-Reply-To: <87vc9chf23.fsf@lebrac.rtp-net.org>
References: <1361961711-4603-1-git-send-email-javier.martin@vista-silicon.com>
 <1361961711-4603-3-git-send-email-javier.martin@vista-silicon.com>
 <87vc9chf23.fsf@lebrac.rtp-net.org>
Message-ID: <CACKLOr0y6M4O82KRVWSny-wzwmZPGS3pOGkZtdgc1aynH94LRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On 28 February 2013 12:07, Arnaud Patard <arnaud.patard@rtp-net.org> wrote:
> Javier Martin <javier.martin@vista-silicon.com> writes:
>
> Hi,
>
>> SAHARA2 HW module is included in the i.MX27 SoC from
>> Freescale. It is capable of performing cipher algorithms
>> such as AES, 3DES..., hashing and RNG too.
>
> The rmmod oops is gone with this version, thanks.
>
>>
>> This driver provides support for AES-CBC and AES-ECB
>> by now.
>>
>> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
>> ---
>>  drivers/crypto/Kconfig  |   10 +
>>  drivers/crypto/Makefile |    1 +
>>  drivers/crypto/sahara.c | 1070 +++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 1081 insertions(+)
>>  create mode 100644 drivers/crypto/sahara.c
>>
>> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
>> index 87ec4d0..7d73f5a 100644
>> --- a/drivers/crypto/Kconfig
>> +++ b/drivers/crypto/Kconfig
>> @@ -276,6 +276,16 @@ config CRYPTO_DEV_PICOXCELL
>>
>>         Saying m here will build a module named pipcoxcell_crypto.
>>
>> +config CRYPTO_DEV_SAHARA
>> +     tristate "Support for SAHARA crypto accelerator"
>> +     depends on MACH_MX27 && EXPERIMENTAL && OF
>
> maybe switch to ARCH_MXC instead of MAC_MX27 ?
>
> [...]
>
>> +static struct platform_driver sahara_driver = {
>> +     .probe          = sahara_probe,
>> +     .remove         = __devexit_p(sahara_remove),
>
> Please remove the __devexit_p too.
>
>
> For information, you'll find below what I've changed to test the driver on my
> imx51. It's not perfect but it's enough for testing things.
>
>

Since I have to send v3 anyway to comply with Sascha's request maybe
it would be worth to include  your changes to provide support for
i.mx51 too.

Regards.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
