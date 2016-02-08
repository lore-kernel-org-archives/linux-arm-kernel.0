From: olof@lixom.net (Olof Johansson)
Date: Mon, 8 Feb 2016 13:51:30 -0800
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.6
In-Reply-To: <cover.1454595846.git.horms+renesas@verge.net.au>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
Message-ID: <20160208215130.GJ25468@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 04, 2016 at 03:30:02PM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC DT updates for v4.6.
> 
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.6
> 
> for you to fetch changes up to d7a11140d0a659e5c1f83627792f95b6713030a2:
> 
>   ARM: dts: silk: Enable SCIF_CLK frequency and pins (2016-02-02 14:02:28 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Updates for v4.6
> 
> * Use SCIF and USBHS fallback compatibility strings
> * Add Baud Rate Generator (BRG) support for (H)SCIF
> * Enable SCIF_CLK frequency and pins
> * Use GIC_* defines
> * Migrate to generic l2c OF initialization on r8a7740
> * Enable audio on r8a7793/gose
> * Enable HDMI vidio out on r8a7793
> * Enable i2c on r8a7793/gose
> * Enable QSPI on alt
> * Enable GPIO keys and leds on gise
> * Enable audio on porter
> * Enable DU on porter
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (22):
>       ARM: shmobile: r8a7740: Migrate to generic l2c OF initialization
>       ARM: shmobile: r8a7740: Remove mapping of L2 cache controller registers

Hmm. Those aren't DT changes. There's also nothing for r8a7740 to convert
L2 init to DT earlier in this branch, which makes this look like it's just
a generic cleanup that should go in independently in your cleanup branch.

Or am I missing some dependency that isn't obvious? If I'm not, then please
respin this branch and move those to the place they belong (cleanup).

Thanks!



-Olof
