From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 17 Nov 2015 11:17:40 +0800
Subject: [PATCH] PCI: hisi: fix deferred probing
In-Reply-To: <56459149.8090709@hisilicon.com>
References: <1447329728-1589-1-git-send-email-jszhang@marvell.com>
 <4417267.EzK5DAjM5p@wuerfel> <56459149.8090709@hisilicon.com>
Message-ID: <564A9C54.3090904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2015 03:29 PM, Zhou Wang wrote:
> On 2015/11/12 20:21, Arnd Bergmann wrote:
>> The hisi_pcie_probe function is incorrectly marked as __init, as Kconfig
>> tells us:
>>
>> WARNING: drivers/pci/host/built-in.o(.data+0x7780): Section mismatch in reference from the variable hisi_pcie_driver to the function .init.text:hisi_pcie_probe()
>>
>> If the probe for this device gets deferred past the point where __init
>> functions are removed, or the device is unbound and then reattached to
>> the driver, we branch into uninitialized memory, which is bad.
>>
>> This removes the __init annotation.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>
> Hi Arnd,
>
> Many thanks, it looks good to me. so
> Acked-by: Zhou Wang <wangzhou1@hisilicon.com>

I found this problem too and prepared a patch for it, but
I noticed that Arnd already fixed it :)

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
