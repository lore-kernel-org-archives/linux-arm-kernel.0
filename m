From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 05 Apr 2013 11:21:50 +0200
Subject: [PATCH 3/5 v2] ARM: kirkwood: add device node entries for the
 gigabit interfaces
In-Reply-To: <20130404213517.GB25904@schnuecks.de>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
 <1365071235-11611-4-git-send-email-florian@openwrt.org>
 <20130404213517.GB25904@schnuecks.de>
Message-ID: <515E97AE.4080608@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/04/13 23:35, Simon Baatz a ?crit :
> Hi Florian,
>
> On Thu, Apr 04, 2013 at 12:27:13PM +0200, Florian Fainelli wrote:
>> This patch modifies kirkwood.dtsi to specify the various gigabit
>> interfaces nodes available on kirkwood devices. They are disabled by
>> default and should be enabled on a per-board basis. egiga0 and egiga1
>> aliases are defined for convenience. The mdio node is also present and
>> should be enabled on a per-board basis as well.
>>
>> Signed-off-by: Florian Fainelli <florian@openwrt.org>
>> ---
>> Changes since v1:
>> - dropped change to arch/arm/mach-kirkwood/common.c to avoid merge conflicts
>
> I think we should remove the clock aliases in
> kirkwood_legacy_clk_init() in mach-kirkwood/dt-board.c (once we have
> proper clock support, see my other mail).
>
[snip]
>
> Don't we need to add:
>
> 			interrupts = <46>;
>
> here?

Right this is missing, in fact it still works ok because the orion-mdio 
driver can do busy waiting instead of interrupt signaling. Will fix that 
in the next round, thanks!
--
Florian
