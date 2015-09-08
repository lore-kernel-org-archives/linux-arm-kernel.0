From: mathias.nyman@intel.com (Mathias Nyman)
Date: Tue, 08 Sep 2015 13:45:07 +0300
Subject: [PATCH v7 4/5] xhci: mediatek: support MTK xHCI host controller
In-Reply-To: <1441693083-8440-5-git-send-email-chunfeng.yun@mediatek.com>
References: <1441693083-8440-1-git-send-email-chunfeng.yun@mediatek.com>
 <1441693083-8440-5-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <55EEBC33.5030906@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 08.09.2015 09:18, Chunfeng Yun wrote:
> There some vendor quirks for MTK xhci host controller:
> 1. It defines some extra SW scheduling parameters for HW
>    to minimize the scheduling effort for synchronous and
>    interrupt endpoints. The parameters are put into reseved
>    DWs of slot context and endpoint context.
> 2. Its IMODI unit for Interrupter Moderation register is
>    8 times as much as that defined in xHCI spec.
> 3. Its TDS in  Normal TRB defines a number of packets that
>    remains to be transferred for a TD after processing all
>    Max packets in all previous TRBs.
>

I just rewrote and unified the the xhci TD remainder functions,
now we got only one xhci_td_remainder() function which should
be more suitable for quirks.

You can add the quirk directly to it, no need to duplicate the
whole function.

-Mathias
