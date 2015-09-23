From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 22 Sep 2015 18:06:08 -0700
Subject: [PATCH v2 1/2] ARM: imx35: Do not call mxc_timer_init twice when
 booting with DT
In-Reply-To: <1441791315-25390-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1441791315-25390-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <20150923010608.GF3529@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 09, 2015 at 11:35:14AM +0200, Alexander Stein wrote:
> mxc_timer_init must not be called from within mx35_clocks_init_dt. It will
> eventually be called by imx31_timer_init_dt
> (drivers/clocksource/timer-imx-gpt.c).
> This arranges the initialization code similar to clk-imx27.c
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> Change in v2:
> * Fix typo
> 
>  drivers/clk/imx/clk-imx35.c | 49 +++++++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 22 deletions(-)

Forgot mentioning that patches touching drivers/clk/ should be prefixed
with 'clk: ...' in subject.  I changed the subject of the patch to
'clk: imx35: ...' when applying.

Shawn
