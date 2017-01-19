From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 19 Jan 2017 12:18:28 +0100
Subject: [PATCH v3 06/13] ARM: davinci: da850: model the SATA refclk
In-Reply-To: <ff4deee6-9700-fff3-be96-0ad2f008914b@lechnology.com>
References: <1484745601-4769-1-git-send-email-bgolaszewski@baylibre.com>
 <1484745601-4769-7-git-send-email-bgolaszewski@baylibre.com>
 <ff4deee6-9700-fff3-be96-0ad2f008914b@lechnology.com>
Message-ID: <CAMpxmJWmrwOnnUBHw_5_v9Fort_kphOE0x75hrat6_sXiyAvGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-18 18:26 GMT+01:00 David Lechner <david@lechnology.com>:
> On 01/18/2017 07:19 AM, Bartosz Golaszewski wrote:
>>
>>  int __init da850_register_sata(unsigned long refclkpn)
>>  {
>> +       int ret;
>> +
>>         /* please see comment in drivers/ata/ahci_da850.c */
>>         BUG_ON(refclkpn != 100 * 1000 * 1000);
>
>
> This BUG_ON() should be removed since the sata driver can now handle other
> clock frequencies.
>

Right, will fix in v4.

Thanks,
Bartosz Golaszewski
