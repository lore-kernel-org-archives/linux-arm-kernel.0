From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 11 May 2015 12:45:03 +0300
Subject: [GIT PULL] Ux500 development for v4.2
In-Reply-To: <CACRpkdZX-Tg-1SNV0L2MemGqkaVZG9wSwiLquYVDVMToZT02nw@mail.gmail.com>
References: <CACRpkdZX-Tg-1SNV0L2MemGqkaVZG9wSwiLquYVDVMToZT02nw@mail.gmail.com>
Message-ID: <20150511094503.GW2558@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, May 11, 2015 at 11:32:04AM +0200, Linus Walleij wrote:
> Hi ARM SoC people,

Added ARM SoC address to To:.

baruch

> this is some cleanup and development for Ux500 that should go
> into ARM SoC for the v4.2 series. Details are in the signed tag.
> 
> I think it would look overzealous to break it in different topics, but if you
> prefer to slice the patch set, tell me how and I'll split it as you
> desire.
> 
> Please pull this to ARM SoC!
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
> 
>   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ux500-v4.2-1
> 
> for you to fetch changes up to 11033cb60a6a660a1ced07bb9501dce85e85b0ae:
> 
>   ARM: ux500: add the sensors to the STUIB board (2015-05-11 11:10:16 +0200)
> 
> ----------------------------------------------------------------
> Ux500 development for the v4.2 kernel series:
> - Get some static maps out
> - Device Trees:
>   - Define CPU topology for Ux500's
>   - Add CoreSight blocks for Ux500's
>   - Fix the magnetometer compat string for TVK
>     and Snowball
>   - Assign sensor trigger IRQs for some boards
>   - Add the STUIB sensors
> - Defconfig:
>   - Enable PERF_EVENTS as we have a PMU after all
>   - Enable CoreSight components
> 
> ----------------------------------------------------------------
> Linus Walleij (8):
>       ARM: ux500: define CPU topology
>       ARM: ux500: get rid of static maps
>       ARM: ux500: add CoreSight blocks to DTS file
>       ARM: ux500: add PERF_EVENTS to defconfig
>       ARM: ux500: enable CoreSight in defconfig
>       ARM: ux500: fix lsm303dlh magnetometer compat string
>       ARM: ux500: assign the sensor trigger IRQs
>       ARM: ux500: add the sensors to the STUIB board
> 
>  arch/arm/boot/dts/ste-dbx5x0.dtsi          | 154 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/ste-href-stuib.dtsi      |  50 ++++++++++
>  arch/arm/boot/dts/ste-href-tvk1281618.dtsi |   7 +-
>  arch/arm/boot/dts/ste-snowball.dts         |  23 ++++-
>  arch/arm/configs/u8500_defconfig           |   5 +
>  arch/arm/mach-ux500/cpu-db8500.c           |  13 +--
>  6 files changed, 236 insertions(+), 16 deletions(-)

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
