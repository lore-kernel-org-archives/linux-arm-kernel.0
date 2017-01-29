From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 14:41:43 -0800
Subject: [GIT PULL 1/3] Rockchip driver updates for 4.11 part1
In-Reply-To: <6458001.3c0YmcoF8y@phil>
References: <6458001.3c0YmcoF8y@phil>
Message-ID: <20170129224143.GC3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On Sat, Jan 21, 2017 at 01:10:38AM +0100, Heiko Stuebner wrote:
> Hi Arnd, Kevin, Olof,
> 
> please find below some rockchip-specific soc-driver updates for 4.11.
> It is based on 4.10-rc2 due to the bug in 4.10-rc1 that caused the whole
> arm64 to not build.
> 
> The grf-thingy has been on the lists in some iterations and as the tag
> message says is really only ever meant for stuff that really fits nowhere
> else but can also not be set in firmware in a sane way.
> 
> So if there are no complaints, please pull.

I replied to one of the patches -- I think it can be done better but this can
go in meanwhile and it can be switched over to later.


> 
> The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:
> 
>   Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.11-armsoc-drivers1
> 
> for you to fetch changes up to 19f0f3021e7532a1056886e3ddf524f9847e4f15:
> 
>   ARM: rockchip: drop rk3288 jtag/mmc switch handling (2017-01-06 10:29:16 +0100)
> 
> ----------------------------------------------------------------
> Some extensions to the power-domain driver to support domains in
> hiword registers (write-mask in upper 16bit) and domain-definitions
> for the rk3328 soc.
> 
> Secondly a "driver" that attaches to the already existing grf nodes
> and is able to set static defaults for settings that cannot really
> be attached to any specific subsystem.
> Most GRF settings can already be set from drivers using them, but there
> are some behavioural settings like the mmc/jtag switch that cannot.
> 
> As the commit message states this is really meant as a last line
> of defence for things that neither belong to a subsystem nor to the
> 
> Having this here allows arm64 socs to have this as well and also
> moves another bit of code out of the arm32 mach-rockchip.

Third paragraph looks cut off.

Still, merged.


-Olof
