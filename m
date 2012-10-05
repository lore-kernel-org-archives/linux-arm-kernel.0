From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 5 Oct 2012 18:07:38 +0530
Subject: OMAP4 clock/pm fixes [was: [PATCH v4 2/3] ARM: omap: hwmod: get
 rid of all omap_clk_get_by_name usage
In-Reply-To: <506ED29E.7070403@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>
 <1346230576-20004-3-git-send-email-rnayak@ti.com>
 <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com>
 <503F26A4.3050902@ti.com> <503F5517.4010100@ti.com>
 <1346344933.2327.43.camel@deskari> <5040586D.2020406@ti.com>
 <1346397309.18766.5.camel@lappyti> <504073CF.6010804@ti.com>
 <1346401643.32389.4.camel@deskari> <504075A0.7010708@ti.com>
 <506EAC89.2070307@ti.com> <506ED079.70700@ti.com> <506ED29E.7070403@ti.com>
Message-ID: <506ED492.5010709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 October 2012 05:59 PM, Archit Taneja wrote:
> The other not so good option to make DSS PM work would be to add
> OCPIF_SWSUP_IDLE flag to our l3_main_2__dss_* slave interfaces(which
> have the hack "dss_fck" as slave clock). I gave this approach a try,
> that too isn't working so well. When I disable DSS, I get
> CM_DSS_DSS_CLKCTRL.IDLEST as 0x1, and
> CM_DSS_CLKSTCTRL.CLKACTIVITY_DSS_L3_ICLK is set. I wonder why that's
> happening.

I have seen DSS get stuck in transition, with just a clkdm state toggle
(from say HWSUP to SWWKUP) while its optional clocks are not running.
Thats probably whats happening now.

Did you try keeping the modulemode enabled and see if it really gates
DSS/system sleep. I remember testing with Teros CORE ret/off patches
and I was always seeing DSS modulemode enabled but it wasn't gating
sleep.
