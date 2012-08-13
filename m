From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 13 Aug 2012 17:28:17 -0500
Subject: [PATCH] ARM: mxc: ssi-fiq: Make ssi-fiq.S Thumb-2 compatible
In-Reply-To: <20120813193517.GU1451@pengutronix.de>
References: <1344599604-9623-1-git-send-email-dave.martin@linaro.org>
 <20120813193517.GU1451@pengutronix.de>
Message-ID: <CAKGA1bnRA61JT8tQoHBay+6BSxDO5egiagQm1v05L7Asf+qJ+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 IMX_PIN_REG(MX51_PAD_EIM_DA15, NO_PAD, 0x058, 0, 0x000, 0), /*
MX51_PAD_EIM_DA15__EIM_DA15 */



On Mon, Aug 13, 2012 at 2:35 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi Dave,
>
> On Fri, Aug 10, 2012 at 12:53:24PM +0100, Dave Martin wrote:
>> Because FIQ handlers get copied straight into the vectors page to
>> the FIQ vector entry point, FIQ handlers in a Thumb-2 kernel must
>> start in Thumb-2.  A Thumb-2 kernel enters all exception vectors in
>> Thumb-2.
>
> I finally came along testing this. I have no Thumb2 capable hardware
> to test if it works in thumb2 mode, but at least in Arm mode it works.
> This is enough to not introduce a regression, so we can go for this.

This is the interesting dichotomy; the code is only required truly on
devices where Thumb2 isn't available, right?

What we're after here is a build fix more than anything due to an
overzealous, over-inclusive configuration that can't be easily split.
If the ARM code works on the devices it's intended for, excellent. We
can fix the weird inclusions of the code later (and maybe if we're
splitting v6_v7 into just v6 and v7 configs for some other reason, and
all the users go away, maybe we should bump v7 to default to Thumb2?
:)

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
