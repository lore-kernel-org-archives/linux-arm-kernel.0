From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 27 Mar 2012 18:03:49 -0700
Subject: [PATCH 07/10] clk: Constify parent name arrays
In-Reply-To: <1332833009-4121-8-git-send-email-shawn.guo@linaro.org>
References: <1332833009-4121-1-git-send-email-shawn.guo@linaro.org>
 <1332833009-4121-8-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAJOA=zOXwtpefp2vgHprnmdpaOsHzo_rtMPMrN=X=K7YXM2EYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 12:23 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> From: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> Drivers should be able to declare their arrays of parent names as const
> so the APIs need to accept const arguments.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks for reposting Shawn.

Mark, I've taken this in to my fixes branch, but I dropped the change
in drivers/clk/clk-fixed-rate.c (since that code has shuffled) and I
also marked the char *parent[1] in fixed-rate and gate clocks as
const, in addition to the divider you did in your patch.

Thanks,
Mike
