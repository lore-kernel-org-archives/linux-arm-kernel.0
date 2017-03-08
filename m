From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Wed, 8 Mar 2017 13:08:22 +0200
Subject: [PATCH 1/2] usb: xhci-mtk: check hcc_params after adding primary
 hcd
In-Reply-To: <1488934285.14325.8.camel@mhfsdcap03>
References: <1488857543-9384-1-git-send-email-chunfeng.yun@mediatek.com>
 <58BECD83.9000205@linux.intel.com> <1488934285.14325.8.camel@mhfsdcap03>
Message-ID: <58BFE626.6030107@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.03.2017 02:51, Chunfeng Yun wrote:
> On Tue, 2017-03-07 at 17:10 +0200, Mathias Nyman wrote:
>> On 07.03.2017 05:32, Chunfeng Yun wrote:
>>> hcc_params is set in xhci_gen_setup() called from usb_add_hcd(),
>>> so checks the Maximum Primary Stream Array Size in the hcc_params
>>> register after adding primary hcd.
>>>
>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>
>> Thanks.
>> Looks like streams check has never worked for Mediatek xHC hosts,
>>
>> Do you know if this has caused any issues?
>> looks like it should go usb-linus and maybe stable kernels as well.
> No issues on mt8173, because it doesn't support bulk stream. But it
> causes a issue on the newest SoC which is not upstreamed, so I think it
> needn't go stable kernels.
>

Ok, thanks, skipping stable

-Mathias
