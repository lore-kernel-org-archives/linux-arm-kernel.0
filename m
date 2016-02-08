From: architt@codeaurora.org (Archit Taneja)
Date: Mon, 8 Feb 2016 17:56:27 +0530
Subject: [PATCH v7 0/5] Add mipi dsi support for rk3288
In-Reply-To: <5060470.dfeHX20DRa@phil>
References: <1452053038-32098-1-git-send-email-zyw@rock-chips.com>
 <56B869F4.6090507@codeaurora.org> <5060470.dfeHX20DRa@phil>
Message-ID: <56B88973.6000701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/08/2016 04:22 PM, Heiko Stuebner wrote:
> Hi Archit,
>
> Am Montag, 8. Februar 2016, 15:42:04 schrieb Archit Taneja:
>> On 01/06/2016 09:33 AM, Chris Zhong wrote:
>>> The rk3288 MIPI DSI is a Synopsys DesignWare MIPI DSI host controller
>>> IP. This series adds support for a Synopsys DesignWare MIPI DSI host
>>> controller DRM driver.
>>>
>>> The MIPI DSI feature is tested on rk3288 evb board, backport them to
>>> chrome os kernel chrome_v3.14, and it can display normally.
>>>
>>> This patchset is base on the patchset from Ying.liu at freescale.com.
>>> <http://www.spinics.net/lists/dri-devel/msg77181.html>
>>>
>>> According to the suggestion from Thierry, I have get rid of the bridge,
>>> and register the encoder & connecter in drm/rockchip/dw-mipi-dsi.c.
>>
>> I've raised this question too late, but what was the reason to not
>> implement the DSI block as a bridge driver?
>
> There seems to always be some sort of contention about those being bridge
> drivers - I think I remember Thierry speaking up about that. But I don't
> remember if any different solution was suggested.

Well, yeah, these can be considered as encoders too. I guess it's just
not very common to have encoder drivers outside of the kms driver, in
comparison to bridges.

The advantage of having such shared IPs as bridges is that they can be
used by kms drivers that already implement an encoder in the display
chain.

>
> Also as we have seen with current shared IPs (dw-hdmi + analogix-dp) there
> are always implementation-specific parts and deciding which needs to land
> where is difficult without the secondary user present.

Yeah, I can imagine it being hard to separate out the implementation
specific and core parts.

>
> The first iterations where using a bridge-driver-base for it but I guess it
> was to much hassle without seeing another user on the horizon.
>
>
>> The drm/hisilicon IP seems to use a very similar DSI Designware IP (the
>> register offsets seems to be the same). There is a good potential of
>> re-use here by different kms drivers here the way it's already done for
>> DW HDMI and the analogix DP driver that's in review process.
>
> I guess, the second user now gets to do the generalization ;-)

If not the generalization, then at least an assessment if it's worth the
effort or not :)

Archit

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum, hosted by The Linux Foundation
