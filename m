From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 04 Mar 2014 10:08:56 +0100
Subject: [PATCH v2] CNS3xxx: Fix PCIe early iotable_init().
In-Reply-To: <m3r46io1nd.fsf@t19.piap.pl> ("Krzysztof =?utf-8?Q?Ha=C5=82as?=
 =?utf-8?Q?a=22's?= message of "Tue, 04 Mar 2014 08:37:10 +0100")
References: <m3eh2nqz7n.fsf@t19.piap.pl> <m3r46io1nd.fsf@t19.piap.pl>
Message-ID: <m3eh2inxef.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

khalasa at piap.pl (Krzysztof Ha?asa) writes:

> This patch fixes the following BUG:
>
>> kernel BUG at mm/vmalloc.c:1132!
>> PC is at vm_area_add_early+0x20/0x84
>> LR is at add_static_vm_early+0xc/0x60
>>
>> The problem is cns3xxx_pcie_init() (device_initcall) calls the "early"
>> iotable_init().

That's obviously:

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
