From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 22 Dec 2015 14:38:03 -0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable GPU support
In-Reply-To: <20151222161642.GO8644@n2100.arm.linux.org.uk>
References: <1450723442-1518-1-git-send-email-festevam@gmail.com>
 <20151222122154.GD26290@tiger>
 <CAOMZO5A8BEkNvrazmksRBRUQw+4mWwbfKtrK6KzD3XK5L5Fs7w@mail.gmail.com>
 <1450788454.2637.17.camel@pengutronix.de>
 <20151222125300.GH8644@n2100.arm.linux.org.uk>
 <20151222150259.GL8644@n2100.arm.linux.org.uk>
 <CAOMZO5CXqNNv7hv0kwyqQiQvo4d_X1jN8jf4QPmEJQvMogHzGA@mail.gmail.com>
 <20151222161642.GO8644@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5Cmm2AMhBY-MgR34PP2gHS2HhKprWOtjKD+vOr5R5OEQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 2:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Jon is busy at the moment, and I expect will reply in a few hours or
> so.
>
> On Tue, Dec 22, 2015 at 01:31:53PM -0200, Fabio Estevam wrote:
>> It seems the information you got from Jon is not correct.
>
> I suspect Jon is in a better position to comment about what works and
> what doesn't, as he's doing the customer facing support for SolidRun,
> and has to deal with people trying to run stock u-boot on SolidRun's
> hardware.
>
> _Especially_ when he gets regular reports from users trying to run
> Fedora 23 on SolidRun platforms, which ships with mainline u-boot,
> and it fails to work because mainline u-boot gets stuff wrong.  The
> telling thing for Jon is that when he gets users to switch to SR's
> u-boot, the problems magically vanish.

That's a good feedback. I will review the DDR3 settings in mainline
U-boot against SolidRun's tree.

> Jon is aware of what's in mainline u-boot, and the memory timings there
> are wrong.  For a start, the highest DDR clock rate is 1066MHz, not
> 1600MHz that you have in mainline u-boot.  So you're overclocking the
> SDRAM.

No, we don't:

    /* Limit mem_speed for MX6D/MX6Q */
    if (is_cpu_type(MXC_CPU_MX6Q) || is_cpu_type(MXC_CPU_MX6D)) {
        if (mem_speed > 1066)
            mem_speed = 1066; /* 1066 MT/s */

> I know that Jon has put a _lot_ of effort into getting the SDRAM setup
> stable on SolidRun hardware to eliminate hangs and other problems, and
> it seems the attitude is "we don't care about that, we're mainline, we
> know better."

Would be wonderful to have these changes upstreamed.
