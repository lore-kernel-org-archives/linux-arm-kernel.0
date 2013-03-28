From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 28 Mar 2013 14:36:30 -0400
Subject: [PATCHv3] ARM: kirkwood: Add support for NETGEAR ReadyNAS Duo
 v2 using DT
In-Reply-To: <87ppyvautl.fsf@natisbad.org>
References: <8738vt3h11.fsf@natisbad.org> <20130317205047.GU21478@lunn.ch>
 <87mwtzcgbl.fsf@natisbad.org> <20130319211607.GE21478@lunn.ch>
 <87ppyvautl.fsf@natisbad.org>
Message-ID: <20130328183630.GC13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 11:28:06PM +0100, Arnaud Ebalard wrote:
> Hi,
> 
> Add support for NETGEAR ReadyNAS Duo v2 (Hardware specs available
> here: http://natisbad.org/NAS/). Almost everything is supported via
> provided .dts. A board-readynas.c file is nonetheless required for
> device not only converted to DT (Gbit controller).
> 
> FWIW, the most noticeable lack regarding hardware support is the fan
> controller (GMT G762) for which nothing is currently available
> upstream.
> 
> Changes since v2:
>  - tried and respect alphabetical order where possible in additions
>  - removed useless inclusion of io.h and delay.h in board-readynas.c
> 
> Changes since v1:
>  - More specific compatible string in dts
>  - Moved declaration to keep dts Makefile in alphabetical order
>  - Removed unneeded mdelay() for USB power on
>  - Switched to fixed regulator in .dts for USB power on
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> Tested-By: Arnaud Ebalard <arno@natisbad.org>
> ---

[1] see below.

> 
> A previous version of the patch has been tested against 3.8.3 and the
> one below against current arm tree (current head of rmk/for-next).
> 
>  arch/arm/boot/dts/Makefile                         |    1 +
>  .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  180 ++++++++++++++++++++
>  arch/arm/configs/kirkwood_defconfig                |    1 +
>  arch/arm/mach-kirkwood/Kconfig                     |    9 +
>  arch/arm/mach-kirkwood/Makefile                    |    1 +
>  arch/arm/mach-kirkwood/board-dt.c                  |    4 +
>  arch/arm/mach-kirkwood/board-readynas.c            |   28 +++
>  arch/arm/mach-kirkwood/common.h                    |    6 +
>  8 files changed, 230 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
>  create mode 100644 arch/arm/mach-kirkwood/board-readynas.c

Applied to mvebu/boards

Edited the commit message to remove conversational text and changelog.
In the future, please place these here [1].  Other than that, great
first patch, thanks!

thx,

Jason.
