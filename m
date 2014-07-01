From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 01 Jul 2014 16:20:20 +0800
Subject: [PATCH v4 13/13] ARM64 / ACPI: Enable ARM64 in Kconfig
In-Reply-To: <53B2694F.7070501@linaro.org>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
 <1403840976-7456-14-git-send-email-hanjun.guo@linaro.org>
 <20140630104652.GG28951@arm.com> <53B2694F.7070501@linaro.org>
Message-ID: <53B26F44.7050404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>>>  	depends on PCI
>>>  	select PNP
>>> -	default y
>>> +	default y if !ARM64
>>
>> For the benefit of single Image, I think you can default to y here.
> 
> It ok to me. if we default to y here, devicetree will not be unflattened
> in default, is it ok to you? you can refer to "[PATCH 12/13] ARM64 / ACPI: if
> we chose to boot from acpi then disable FDT".

Ah, sorry I didn't describe it clearly. since there is no shipping board
with ACPI tables, so ACPI will disabled in the very early stage and FDT
still have chance to be unflattened, so will not break DT booting in
this patchset.

Thanks
Hanjun
