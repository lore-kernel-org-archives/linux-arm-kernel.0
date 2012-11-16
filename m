From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 16 Nov 2012 04:23:18 -0200
Subject: [PATCH 7/8] ata: highbank: mark ahci_highbank_probe as __devinit
In-Reply-To: <50A5C4C7.4090309@pobox.com>
References: <1352238933-4886-1-git-send-email-arnd@arndb.de>
 <1352238933-4886-8-git-send-email-arnd@arndb.de>
 <50A5C4C7.4090309@pobox.com>
Message-ID: <CAOMZO5A4YA85ZSXG2_D9yP3+TzW0FSCU1h9WjPDzJr_Er46SrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeff,

On Fri, Nov 16, 2012 at 2:44 AM, Jeff Garzik <jgarzik@pobox.com> wrote:
> On 11/06/2012 04:55 PM, Arnd Bergmann wrote:
>>
>> The ahci_highbank_probe function is incorrectly marked as __init,
>> which means it can get discarded at boot time, which might be
>> a problem if for some reason the device only becomes operational
>> after loading another module.
>>
>> Using __devinit instead avoids seeing this warning for every build:
>>
>> WARNING: vmlinux.o(.data+0xf7b0): Section mismatch in reference from the
>> variable ahci_highbank_driver to the function
>> .init.text:ahci_highbank_probe()
>> The variable ahci_highbank_driver references
>> the function __init ahci_highbank_probe()
>> If the reference is valid then annotate the
>> variable with __init* or __refdata (see linux/init.h) or name the
>> variable:
>> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Jeff Garzik <jgarzik@redhat.com>
>> ---
>>   drivers/ata/sata_highbank.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> applied

I have also sent the same fix:
https://patchwork.kernel.org/patch/1562141/
