From: a0393675@ti.com (Keerthy)
Date: Fri, 20 Dec 2013 12:22:16 +0530
Subject: [PATCHv11 00/49] ARM: TI SoC clock DT conversion
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Message-ID: <52B3E920.5090305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

On Thursday 19 December 2013 04:53 PM, Tero Kristo wrote:
> Hi,
>
> So, once again new series. I guess I should have addressed all comments
> for v10 except the extern sharing of __clk_of_table. Based on discussion
> with Mike, this should be fine to fix later.
>
> Main changes compared to v10:
> - rebased on top of 3.13-rc4
> - applied clk_desc support from Mike, did some cleanups and additions to that
>    * needed for below item, clk_ll_ops
> - added support for clk_ll_ops, and removed SoC wide clock ops
>    * used for wrapping the IP block specific register access routines now
> - removed need for separate init function types because of above two points,
>    TI clocks also use the standard prototype now, no return value needed
> - cleaned up the init retry logic for TI clocks a bit (DPLL/APLL)
> - added clocks {} and clockdomains {} nodes under the master clock IP nodes,
>    which are used to group clocks and domains accordingly
> - changed compatible strings for clock master IPs from ti,clock-master to
>    something of form ti,omap4-prm etc.
>
> omap3 legacy clock data is not removed with this series, this can be done
> later (basically I want someone to test all the possible omap3 boards out
> there with DT boot before attempting this.)
>
> Testing done:
> - omap3-beagle: boot, suspend-resume (ret), suspend-resume (off)
> - omap4-panda-es: boot, suspend-resume (ret)
> - omap5-uevm: boot
> - dra7-evm: boot
> - am335x-bone: boot

I boot tested the branch '3.13-rc4-dt-clks-v11' on am43x-epos-evm
and it boots fine after enabling am43x system type.

> Branches again available here:
> https://github.com/t-kristo/linux-pm.git
>
> branch: 3.13-rc4-dt-clks-v11 : contains everything, shall me merged last
> branch: 3.13-rc4-dt-clks-v11-for-mike : drivers/clk changes
> branch: 3.13-rc4-dt-clks-v11-for-benoit : DT data only
>
> -Tero
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,
Keerthy
