From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 06 Jan 2011 11:41:55 +0100
Subject: [PATCH v4 5/8] arm: mxc: move IOMUX_CONFIG_XXXX definitions to
	iomux-v3.h
In-Reply-To: <20110106101639.GE26009@pengutronix.de> (Sascha Hauer's message
	of "Thu, 6 Jan 2011 11:16:39 +0100")
References: <1293708306-20170-1-git-send-email-richard.zhao@freescale.com>
	<1293708306-20170-2-git-send-email-richard.zhao@freescale.com>
	<1293708306-20170-3-git-send-email-richard.zhao@freescale.com>
	<1293708306-20170-4-git-send-email-richard.zhao@freescale.com>
	<1293708306-20170-5-git-send-email-richard.zhao@freescale.com>
	<20110106065935.GA15509@shlinux1.ap.freescale.net>
	<20110106101639.GE26009@pengutronix.de>
Message-ID: <87oc7u71qk.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:
Hi,

> On Thu, Jan 06, 2011 at 02:59:36PM +0800, Richard Zhao wrote:
>> Hello Sascha,
>> 
>> On Thu, Dec 30, 2010 at 07:25:04PM +0800, Richard Zhao wrote:
>> > IOMUX_CONFIG_GPIO is not for iomux-v3. It's for old freescale
>> > iomux routines. Remove it.
>> > 
>> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
>> > Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> If you don't have comments, could you please merge this patch?
>> It's causing arch/arm/plat-mxc/include/mach/iomux-mx50.h incomplete.
>
> I didn't apply it because it conflicts with current imx-for-2.6.38
> branch. Other than that I don't find the enum very useful at all,
> because we have problems with very long lines in these files and
> using IOMUX_CONFIG_ALT0 where we could use 0 does not exactly improve
> the situation.

While I agree with this, there's a small exception. I found out
yesterday that now, there's no more any macro/enum defined for the
infamous SION bit. Theses means that currently to defined a PAD with
SION bit set, we have to create a new macro with IOMUX_PAD instead
of using the _MX51_PAD_* macro as basis. Did I miss something ?

Arnaud
