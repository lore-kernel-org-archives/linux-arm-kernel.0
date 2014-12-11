From: Ying.Liu@freescale.com (Liu Ying)
Date: Thu, 11 Dec 2014 13:50:00 +0800
Subject: [PATCH RFC 04/15] drm/dsi: Do not add DSI devices for the child
 nodes with input-port property
In-Reply-To: <548906FD.5070009@freescale.com>
References: <1418200648-32656-1-git-send-email-Ying.Liu@freescale.com>
 <1418200648-32656-5-git-send-email-Ying.Liu@freescale.com>
 <20141210122105.GC23558@ulmo.nvidia.com> <548906FD.5070009@freescale.com>
Message-ID: <54893088.4000203@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On 12/11/2014 10:52 AM, Liu Ying wrote:
> Hi Thierry,
>
> On 12/10/2014 08:21 PM, Thierry Reding wrote:
>> On Wed, Dec 10, 2014 at 04:37:17PM +0800, Liu Ying wrote:
>>> The MIPI DSI bus driver would try to add a DSI device for a host's every
>>> child node which contains the reg property.  Unfortunately, the existing
>>> i.MX6Q/SDL MIPI DSI host device tree node's child nodes contain the reg
>>
>> There aren't any existing nodes for the DSI host on i.MX. This patch
>> series adds support for them.
>
> There are existing nodes for the DSI host node. Please find them in
> arch/arm/boot/dts/imx6qdl.dtsi and arch/arm/boot/dts/imx6q.dts. The DSI
> host node contains two child nodes for i.MX6DL and another two for
> i.MX6Q.  Each child node has a reg property embedded.
>
>>
>>> property, but the child nodes are ports pointing to dedicated CRTCs.
>>> So, this patch phases out the child nodes with input-port property
>>> before
>>> adding DSI devices for them and updates the MIPI DSI bus OF binding
>>> documentation.
>>>
>>> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
>>> ---
>>>   Documentation/devicetree/bindings/mipi/dsi/mipi-dsi-bus.txt | 4 ++++
>>>   drivers/gpu/drm/drm_mipi_dsi.c                              | 5 +++--
>>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> Sorry, but NAK. There's no need for this special-case. I'll go into more
>> detail in response to patch 09/15.
>
> Thanks for reviewing the patches.
>
> Any idea how to handle the special case?  The existing child nodes for
> the DSI host node do have the reg properties embedded.
>

I see your suggestions on this topic in the comments for patch 09/15.
I will try to move the existing child nodes into a parent port node.

Liu Ying

>
>>
>> Thierry
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
