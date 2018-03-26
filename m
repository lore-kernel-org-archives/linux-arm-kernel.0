From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 26 Mar 2018 16:34:41 +0800
Subject: [PATCH v2] ARM: mxs_defconfig: Re-sync defconfig
In-Reply-To: <1521220209-27621-1-git-send-email-festevam@gmail.com>
References: <1521220209-27621-1-git-send-email-festevam@gmail.com>
Message-ID: <20180326083439.GC8857@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 02:10:09PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Re-sync the defconfig by doing:
> 
> make savedefconfig
> cp defconfig arch/arm/configs/mxs_defconfig
> 
> So keep it in sync to help further changes in defconfig.
> 
> The explanation for removing the Kconfig symbols:
> 
> CONFIG_FHANDLE=y: verified that it is still selected
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set: verified that it is still not
> selected
> CONFIG_DEVPTS_MULTIPLE_INSTANCES=y: does not exist anymore
> # CONFIG_DEVKMEM is not set: verified that it is still not selected
> CONFIG_NVMEM=y: verified that it is still selected
> CONFIG_LOCKUP_DETECTOR=y: need to select CONFIG_SOFTLOCKUP_DETECTOR now
> CONFIG_TIMER_STATS=y: does not exist anymore
> 
> Boot tested on a imx28evk.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
