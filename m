From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Tue, 13 May 2014 11:24:51 +0300
Subject: [PATCHv5 08/20] usb: host: xhci-plat: add support for the Armada
 375/38x XHCI controllers
In-Reply-To: <20140512193617.011aa958@free-electrons.com>
References: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>	<1399832288-19899-9-git-send-email-thomas.petazzoni@free-electrons.com>	<537103DD.5030906@linux.intel.com>
 <20140512193617.011aa958@free-electrons.com>
Message-ID: <5371D6D3.6060809@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2014 08:36 PM, Thomas Petazzoni wrote:
> Dear Mathias Nyman,
>
> On Mon, 12 May 2014 20:24:45 +0300, Mathias Nyman wrote:
>
>>> +int xhci_mvebu_mbus_init_quirk(struct platform_device *pdev)
>>> +{
>>> +	struct resource	*res;
>>> +	void __iomem *base;
>>> +	const struct mbus_dram_target_info *dram;
>>
>> Hi
>>
>> Sparse warns about this:
>>
>> drivers/usb/host/xhci-mvebu.c:42:5: warning: symbol 'xhci_mvebu_mbus_init_quirk'
>> was not declared. Should it be static?
>
> Not, it should not: it gets called from xhci-plat.c. However,
> xhci-mvebu.c should include its header xhci-mvebu.h so that sparse
> realize that the function is voluntarily exported, and that therefore
> not having the static qualifier is expected.
>
> Should we resend a v6 with just this change?
>

Not if this is the only thing that needs fixing.
But if you anyway need to make a new version (Kishon had some remarks) then please 
include the header to xhci-mvebu at the same time.

-Mathias
