From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Mon, 9 Jul 2012 17:17:07 +0530
Subject: [PATCHv11 0/6] I2C cleanups
In-Reply-To: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <CAM=Q2ct0PUisYGcaX6EAPWT-SmZAgRV_O8mAOodH-V4Q0O-Vww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 8:41 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> This is a minimal cleanup series.

If there are no further comments can this series be queued?


>
> The patch series does the following
>
> - Bus busy recovery mechanism.
> - Make the i2c use SET_RUNTIME_PM_OPS
> - Use INIT_COMPLETION instead of init_completion
> - the reset patch is dropped will try to rework it as per the
>  review comments recieved.
>
>
> This applies on Wolfram's i2c-embedded/for-next branch.
>
> Functional testing on omap4430 , 4460 panda and omap3sdp.
>
>
> The following changes since commit 0f009a914b40be8786fa67b1f4345cacc263b48c:
>
>   i2c: tegra: make all resource allocation through devm_* (2012-06-13 16:01:38 +0200)
>
> are available in the git repository at:
>   git://gitorious.org/linus-tree/linus-tree.git for_next/omap/minimal_cleanup
>
> Jon Hunter (1):
>   i2c: omap: Correct I2C revision for OMAP3
>
> Shubhrajyoti D (4):
>   i2c: omap: Optimise the remove code
>   i2c: omap: Use SET_RUNTIME_PM_OPS
>   i2c: omap: Do not initialise the completion everytime
>   i2c: omap: Remove the definition of SYSS_RESETDONE_MASK
>
> Vikram Pandita (1):
>   i2c: omap: Recover from Bus Busy condition
>
>  drivers/i2c/busses/i2c-omap.c |   60 ++++++++++++++++++++++++++++------------
>  1 files changed, 42 insertions(+), 18 deletions(-)
>
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
