From: zyw@rock-chips.com (Chris Zhong)
Date: Fri, 12 Aug 2016 08:39:29 +0800
Subject: [v2 PATCH] clk: rockchip: mark rk3399 hdcp_noc and vio_noc as
 critical
In-Reply-To: <1721159.V5xB9fz0jT@diego>
References: <1470765753-11619-1-git-send-email-zyw@rock-chips.com>
 <1721159.V5xB9fz0jT@diego>
Message-ID: <57AD1AC1.5080600@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko


On 08/12/2016 06:17 AM, Heiko St?bner wrote:
> Am Dienstag, 9. August 2016, 11:02:33 schrieb Chris Zhong:
>> Fix incorrect rk3399 aclk_vio gating bit, it should be 0, not 10. With
>> this modification, the aclk_vio_noc should be put into critical list,
>> since it is required by VOP.
>> And the Type-C DP need these clocks: aclk_hdcp_noc, hclk_hdcp_noc,
>> pclk_hdcp_noc. Mark them as critical to avoid someone close them.
>>
>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> I've split that patch in two and applied them there:
> https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v4.8-clk/fixes&id=a3f457d9636b3f5ae4fc6502cb0c95f60f5e342b
> (gate-bit-fix)
> https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v4.9-clk/next&id=54479449c801e46ee2b6ba08e2f19cd810f74f94
> (critical clocks)
>
> with the provided Reviewed-bys.
with the "gate-bit-fix" patch, probably someone will find the panel can 
not display, since the aclk_vio_noc would be disabled default, and this 
noc clk is required by VOP.
So, if someone want to pick up "gate-bit-fix", please get the one 
"critical clocks" firstly.

>
>
> Heiko
>
>
>
