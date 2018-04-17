From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Apr 2018 11:12:41 +0800
Subject: [PATCH v6 01/11] ARM: sunxi: smp: Move assembly code into a file
In-Reply-To: <20180416215032.5023-2-mylene.josserand@bootlin.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-2-mylene.josserand@bootlin.com>
Message-ID: <CAGb2v67VL70yqTF7xq4T3_9zA9T3UT2AV0gGarh1mqvC17r3Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 5:50 AM, Myl?ne Josserand
<mylene.josserand@bootlin.com> wrote:
> Move the assembly code for cluster cache enabling and resuming
> into an assembly file instead of having it directly in C code.
>
> Remove the CFLAGS because we are using the ARM directive "arch"
> instead.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/mach-sunxi/Makefile  |  4 +--
>  arch/arm/mach-sunxi/headsmp.S | 80 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-sunxi/mc_smp.c  | 82 +++----------------------------------------
>  3 files changed, 85 insertions(+), 81 deletions(-)
>  create mode 100644 arch/arm/mach-sunxi/headsmp.S

I'm still not convinced about this whole "move ASM to separate
file" thing, especially now that you aren't actually adding any
sunxi-specific ASM code beyond a simple function call.

Could you drop this for now?

ChenYu
