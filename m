From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 17 Nov 2014 12:07:16 +0100
Subject: [PATCH V3] ARM: tegra: Re-add removed SoC id macro to
 tegra_resume()
In-Reply-To: <1412947487-24287-1-git-send-email-digetx@gmail.com>
References: <1412947487-24287-1-git-send-email-digetx@gmail.com>
Message-ID: <20141117110715.GB25699@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 05:24:47PM +0400, Dmitry Osipenko wrote:
> Commit d127e9c ("ARM: tegra: make tegra_resume can work with current and later
> chips") removed tegra_get_soc_id macro leaving used cpu register corrupted after
> branching to v7_invalidate_l1() and as result causing execution of unintended
> code on tegra20. Possibly it was expected that r6 would be SoC id func argument
> since common cpu reset handler is setting r6 before branching to tegra_resume(),
> but neither tegra20_lp1_reset() nor tegra30_lp1_reset() aren't setting r6
> register before jumping to resume function. Fix it by re-adding macro.
> 
> Fixes: d127e9c (ARM: tegra: make tegra_resume can work with current and later chips)
> Cc: <stable@vger.kernel.org> # v3.13+
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> V2: added Cc's for lakml and stable, added "Reviewed-by:" Felipe Balbi
> V3: changed commit description, tested on real hw
> 
> PS: It wasn't a bug in my emulator :)
> 
>  arch/arm/mach-tegra/reset-handler.S | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/48b17ba4/attachment.sig>
