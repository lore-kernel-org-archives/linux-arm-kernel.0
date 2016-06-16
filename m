From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 17 Jun 2016 01:35:28 +0200
Subject: [PATCH 1/4] phy: rockchip-emmc: give DLL some extra time to be
 ready
In-Reply-To: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
References: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
Message-ID: <2019301.c5hsQIZXPF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 12. Mai 2016, 15:43:03 schrieb Brian Norris:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> According to the databook, 10.2us is the max time for dll to be ready to
> work. However in testing, some chips need 20us for dll to be ready. This
> patch adds some extra margin for dllrdy to be ready, fixing our
> -ETIMEDOUT issues.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

haven't looked to deep into the emmc-phy block, but on my rk3399-evb board 
the emmc still runs nicely with this patch, so

Tested-by: Heiko Stuebner <heiko@sntech.de>
