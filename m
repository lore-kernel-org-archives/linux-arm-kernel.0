From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 2 Dec 2015 13:24:29 +0800
Subject: [PATCH 1/3] ARM: imx: clk-vf610: fix SAI clock tree
In-Reply-To: <1445141122-14183-1-git-send-email-stefan@agner.ch>
References: <1445141122-14183-1-git-send-email-stefan@agner.ch>
Message-ID: <20151202052429.GE692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 17, 2015 at 09:05:20PM -0700, Stefan Agner wrote:
> The Synchronous Audio Interface (SAI) instances are clocked by
> independent clocks: The bus clock and the audio clock (as shown in
> Figure 51-1 in the Vybrid Reference Manual). The clock gates in
> CCGR0/CCGR1 for SAI0 through SAI3 are bus clock gates, as access
> tests to the registers with/without gating those clocks have shown.
> The audio clock is gated by the SAIx_EN gates in CCM_CSCDR1,
> followed by a clock divider (SAIx_DIV). Currently, the parent of
> the bus clock gates has been assigned to SAIx_DIV, which is not
> involved in the bus clock path for the SAI instances (see chapter
> 9.10.12, SAI clocking in the Vybrid Reference Manual).
> 
> Fix this by define the parent clock of VF610_CLK_SAIx to be the bus
> clock.
> 
> If the driver needs the audio clock (when used in master mode), a
> fixed device tree is required which assign the audio clock properly
> to VF610_CLK_SAIx_DIV.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Hi all,
> 
> Patch 1 and 2 are actual fixes and should be applied toghether. If
> the clock tree changes are applied only, master mode won't work
> anymore. With only the device tree changes applied, it probably
> will still work but the VF610_CLK_SAIx_DIV will be enabled twice.
> 
> Since Patch 3 also uses the fixed clock layout, it should be
> applied after the clock tree fix too...

Applied all 3, thanks.
