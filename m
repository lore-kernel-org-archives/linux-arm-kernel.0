From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 9 Mar 2016 10:14:53 +0100
Subject: [PATCH V5 01/15] ACPI: MCFG: Move mmcfg_list management to
 drivers/acpi
In-Reply-To: <56DFE91E.10105@semihalf.com>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-2-git-send-email-tn@semihalf.com>
 <20160303225152.GA10472@localhost>
 <CAKc_7PUyf8ND8Nd32yDBtBnFbkd1mJ-VsCih6YsEA5ZuBUz5zA@mail.gmail.com>
 <20160305041443.GA15110@localhost> <56DFE91E.10105@semihalf.com>
Message-ID: <56DFE98D.5010906@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.03.2016 10:13, Tomasz Nowicki wrote:
>> So I think we should write generic MCFG and ECAM support from scratch
>> for arm64.  Something like this:
>>
>>    - Add an acpi_mcfg_init(), maybe in drivers/acpi/pci_mcfg.c, to be
>>      called from acpi_init() to copy MCFG info to something we can
>>      access after __init.  This would not reserve resources, but
>>      probably does have to ioremap() the regions to support
>>      raw_pci_read().
>
> As said, ECAM and ACPI specific code was isolated in previous patch.

I meant to say, in my previous patch set (V4), sorry.

Tomasz
