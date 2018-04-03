From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 3 Apr 2018 14:52:45 +0800
Subject: [PATCH v5 01/13] ARM: move cputype definitions into another file
In-Reply-To: <20180403061836.3926-2-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-2-mylene.josserand@bootlin.com>
Message-ID: <CAGb2v64GL=1UcYs1tFp-mS07vbHBao82SEhyzUrUHB++2-EKBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 3, 2018 at 2:18 PM, Myl?ne Josserand
<mylene.josserand@bootlin.com> wrote:
> To add the support for SMP on sun8i-a83t, we will use some
> definitions in an assembly file so move definitions into
> another file to separate C functions and macro defintions.

Instead of moving the definitions, you could guard all the C
stuff in "#ifndef __ASSEMBLY__". AFAIK a few header files do that.

ChenYu

> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/include/asm/cputype.h     | 94 +-----------------------------------
>  arch/arm/include/asm/cputype_def.h | 98 ++++++++++++++++++++++++++++++++++++++
