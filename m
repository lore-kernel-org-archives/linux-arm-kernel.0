From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 10:32:46 -0700
Subject: [GIT PULL] gxbb: DT64 changes for 4.7
In-Reply-To: <CAOQ7t2aOQ7svJZti+aLy4uyk37TGCYYCw3aHjBQvN6ysy6_vfw@mail.gmail.com>
References: <CAOQ7t2aOQ7svJZti+aLy4uyk37TGCYYCw3aHjBQvN6ysy6_vfw@mail.gmail.com>
Message-ID: <20160413173246.GD19945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 09:56:37PM +0200, Carlo Caione wrote:
> Hi,
> new boards coming for 4.7, Odroid-C2 and the reference boards P200/P201.
> 
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/carlocaione/linux-meson tags/gxbb-dt64
> 
> for you to fetch changes up to ac40004db3fbea89c50083c6f9015ac7061e77b4:
> 
>   ARM64: dts: amlogic: Add P200/P201 boards (2016-03-30 19:52:34 +0200)
> 
> ----------------------------------------------------------------
> Add support for a few more Amlogic S905/GXBB based boards: Hardkernel ODROID-C2
> and Amlogic P200/P201 boards.
> We also fix the memory nodes on the Vega S95 DTS.

So, I'm a little torn on these devicetrees that only add memory and
a UART.  It means that the presence of a DT can't be used to determine if
the platform is supported, since all you can do with it is boot a ramdisk.

Unfortunately, it seems like this is pretty much all the upstream SoC support
consists of today, so there's not much else to do. I'll pick this up for now
but in general I much prefer to have more of the SoC supported when board dts
files are added.


-Olof
