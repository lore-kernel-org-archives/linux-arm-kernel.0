From: dhdang@apm.com (Duc Dang)
Date: Tue, 21 Jun 2016 14:40:15 -0700
Subject: Warning when compiling DTB on X-Gene platform with dtc
 1.4.1-g53bf130b
In-Reply-To: <20160621132515.GC22350@lunn.ch>
References: <CADaLNDnfH8Weo=9jVNAW7LQCvAw23-z5fafwWcer4FSKeYH=ug@mail.gmail.com>
 <20160621132515.GC22350@lunn.ch>
Message-ID: <CADaLND=DPbitW5uZrmH8y0-S+6XwnF0oMr-=uD3zxnBNM_RxiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 6:25 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Tue, Jun 21, 2016 at 02:02:44AM -0700, Duc Dang wrote:
>> Hi Rob,
>>
>> I got warning on unit_address_vs_reg similar to this
>> https://lkml.org/lkml/2016/3/7/43 when using v4.7-rc2 dtc to build dtb
>> for X-Gene Mustang:
>>
>> dhdang at xgene-next=>./scripts/dtc/dtc -O dtb -R 16 -o mustang.dtb
>> arch/arm64/boot/dts/apm/apm-mustang.dts
>>   Warning (unit_address_vs_reg): Node /soc/reboot at 17000014 has a unit
>> name, but no reg property
>>   Warning (unit_address_vs_reg): Node /memory has a reg or ranges
>> property, but no unit name
>>   Warning (unit_address_vs_reg): Node /gpio-keys/button at 1 has a unit
>> name, but no reg property
>>
>> There are nodes that I cannot change the node-name due to backward
>> compatible with old firmware reason (/soc/reboot at 17000014 as an
>> example). Is there any other way to avoid the warning?
>
> I think you have that backwards around. The Kernel needs to be
> backwards compatible with old DT blobs. DT blobs don't generally need
> to be backwards compatible to older kernels.
>
> However, the kernel should however be happy with or without the unit
> name. The unit name is pointless in this case.

I should be more specific: The old firmware I am talking about is the bootloader
(U-Boot). U-Boot relies on the full node names to do device tree
fix-up, so changing
the node names will break the fix-up operation in already-released U-Boot.

>
>         Andrew

Regards,
Duc Dang.
