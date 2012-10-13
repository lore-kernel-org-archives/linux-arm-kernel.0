From: agust@denx.de (Anatolij Gustschin)
Date: Sat, 13 Oct 2012 18:05:12 +0200
Subject: [PATCH] ARM: imx6q: remove imx_src_prepare_restart() call
In-Reply-To: <1345180316-9209-1-git-send-email-shawn.guo@linaro.org>
References: <1345180316-9209-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20121013180512.24ac6c59@wker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, 17 Aug 2012 13:11:56 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> Currently, imx_src_prepare_restart which is called by imx6q_restart
> assumes that cpu0 must be the running cpu, so it disables all secondary
> cpus.  However this is not the case, the restart routine could possibly
> running on cpu1 or any other secondary cores.  In that case, disabling
> the cpu that runs restart routine will hang up system.
> 
> Also it turns out that everything that is done by imx_src_prepare_restart
> is not really necessary, because the watchdog reset will have those
> registers reset properly.  So let's remove the imx_src_prepare_restart
> call completely.

What is the fate of this patch?

Thanks,
Anatolij
