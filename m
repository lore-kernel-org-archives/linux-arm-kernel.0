From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 6 Sep 2016 10:04:36 -0600
Subject: [PATCH 1/3] arm64: dts: berlin4ct: add missing unit name to /soc
 node
In-Reply-To: <20160906105758.GD1425@leverpostej>
References: <20160906085557.4019-1-jszhang@marvell.com>
 <20160906085557.4019-2-jszhang@marvell.com>
 <20160906102208.GB1425@leverpostej> <20160906182048.222cec2f@xhacker>
 <20160906105758.GD1425@leverpostej>
Message-ID: <25d8bfb3-0dbc-8c8d-019c-381d0a1d2994@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2016 04:57 AM, Mark Rutland wrote:
> On Tue, Sep 06, 2016 at 06:20:48PM +0800, Jisheng Zhang wrote:
>> Hi Mark,
>>
>> On Tue, 6 Sep 2016 11:22:08 +0100 Mark Rutland wrote:
>>
>>> On Tue, Sep 06, 2016 at 04:55:55PM +0800, Jisheng Zhang wrote:
>>>> This patch fixes the following DTC warning with W=1:
>>>>
>>>> "Node /soc has a reg or ranges property, but no unit name"
>>>>
>>>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
>>>
>>> The node is only compatible with simple-bus, and so shouldn't have a
>>> reg.
>>
>> IIUC, the warning is caused by "ranges = <0 0 0xf7000000 0x1000000>;"
>
> Hmm.. I've rather confused by that warning. Per ePAPR and the
> devicetree.org spec, the unit-addresss is meant to match the reg
> property, and no mention is made of the ranges property. So I do not
> think that it is necessary to require this.
>
> That warning seems to have gone into DTC in commit c9d9121683b35281
> ("Warn on node name unit-address presence/absence mismatch").
>
> Rob, Stephen, was there some discussion that prompted ranges requiring
> a matching unit-address?

It looks like there was some in response to V2 of the patch which 
introduced this warning in dtc:

https://lkml.org/lkml/2013/9/19/301

I assume that's why Rob added that part to the patch when he reposted it.
