From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 25 Oct 2016 11:32:44 +0800
Subject: [PATCH 1/3] phy: sun4i: check PHY id when poking unknown bit of pmu
In-Reply-To: <20161024082802.ev72szwmuqba5ll4@lukather>
References: <20161024035930.20274-1-icenowy@aosc.xyz>
 <20161024082802.ev72szwmuqba5ll4@lukather>
Message-ID: <1773661477366364@web4j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On Mon, Oct 24, 2016 at 11:59:30AM +0800, Icenowy Zheng wrote:
> 
>> Allwinner SoC's PHY 0, when used as OTG controller, have no pmu part.
>> The code that poke some unknown bit of PMU for H3/A64 didn't check
>> the PHY, and will cause kernel oops when PHY 0 is used.
>>
>> Fixes: b3e0d141ca9f (phy: sun4i: add support for A64 usb phy)
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> 
> Cc'ing stable would be nice.

Yes... As it's also used by H3...

> 
> Apart from that, Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

If I change it to check whether phy->pmu is null, will you keep the ACK?

> 
> Thanks!
> Maxime
> 
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
