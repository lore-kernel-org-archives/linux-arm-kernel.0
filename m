From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jan 2013 10:40:10 -0800
Subject: [GIT PULL] ARM: mvebu fixes for v3.8-rc6
In-Reply-To: <1359472708.4cD60.22570@triton>
References: <1359472708.4cD60.22570@triton>
Message-ID: <20130129184010.GB19906@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 03:18:28PM +0000, Jason Cooper wrote:
> The following changes since commit 09d75bc7d217bd8868899028a98b53423e6b3324:
> 
>   ARM: kirkwood: fix missing #interrupt-cells property (2013-01-23 01:10:48 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/mvebu_fixes_for_v3.8-rc6

Pulled, but:

> 
> for you to fetch changes up to de27686b77f1c5c5dddf06d48fd322c52f098d51:
> 
>   arm: mvebu: i2c come back in defconfig (2013-01-23 15:05:11 +0000)
> 
> ----------------------------------------------------------------
> fixes for v3.8-rc6
> 
>  - add missing gpio interrupt lines to dove dt
>  - fix bad logic for printing MPP error message on orion boards
>  - build proper serial port driver after changing mvebu DT compatible property
>    - This is a change to mvebu_defconfig that I wouldn't usually push out as a
>      fix.  However, the commit
> 
>      b24212f arm: mvebu: Use dw-apb-uart instead of ns16650 as UART driver
> 
>      changed the serial driver for the board in the dts file.  without the patch
>      I've included in this pull, users won't see any log messages.
> 
> ----------------------------------------------------------------
> Gerlando Falauto (1):
>       arm: plat-orion: fix printing of "MPP config unavailable on this hardware"
> 
> Gregory CLEMENT (1):
>       arm: mvebu: i2c come back in defconfig
> 
> Jean-Francois Moine (1):
>       Dove: activate GPIO interrupts in DT

Please keep an eye on the patch subjects you apply. We're trying to standardize
on "ARM: dove: <...>", etc.


-Olof
