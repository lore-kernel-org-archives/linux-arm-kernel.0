From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 19 Jan 2017 14:31:56 +0100
Subject: [PATCH v3 06/13] ARM: davinci: da850: model the SATA refclk
In-Reply-To: <ff4deee6-9700-fff3-be96-0ad2f008914b@lechnology.com>
References: <1484745601-4769-1-git-send-email-bgolaszewski@baylibre.com>
 <1484745601-4769-7-git-send-email-bgolaszewski@baylibre.com>
 <ff4deee6-9700-fff3-be96-0ad2f008914b@lechnology.com>
Message-ID: <CAMpxmJXBx4TUd-T3zuTY=VD=YAZf5kaq1fqbGTOzZrgnLosp1A@mail.gmail.com>
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

I did that in a separate patch coming after the ahci changes to keep
the series bisectable.

Thanks,
Bartosz Golaszewski
