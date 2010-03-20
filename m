From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Sat, 20 Mar 2010 21:40:07 +0300
Subject: [PATCH 1/3] watchdog: Add support for the Freescale MXC watchdog
In-Reply-To: <20100320120939.GA5515@pengutronix.de> (Wolfram Sang's message of
	"Sat, 20 Mar 2010 13:09:39 +0100")
References: <1269011607-23077-1-git-send-email-vzapolskiy@gmail.com>
	<20100320120939.GA5515@pengutronix.de>
Message-ID: <87aau2x2ew.fsf@vovsem.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram Sang <w.sang@pengutronix.de> writes:

> On Fri, Mar 19, 2010 at 06:13:27PM +0300, Vladimir Zapolskiy wrote:
>> Add driver for the Freescale MXC SoCs built-in watchdog.
>
> Any improvements over/differences to this one?
>
> http://article.gmane.org/gmane.linux.ports.arm.kernel/70753
>
> (Read the thread for the comments I received)
>
> Coincidence, I wanted to pick up my version and finish it next week. We have to
> agree how to continue. I like mine a tad better (there are some mixups of
> MX1/2+ capabilities in yours, e.g. SETTIMEOUT) and it also got review already,
> but of course I am biased ;) What do you suggest?
>
> Regards,
>
>    Wolfram

Hi Wolfram,

that's a surprise for me, haven't noticed your version of the driver in
the maillist, and wrote one more watchdog driver :)

The driver is extremely simple, so from my biased position only minor
benefits can be found in my version:
* introduced spinlock to protect concurrent write to registers
* SETTIMEOUT option is present and it works well on imx31
* correct zero byte write()
* clock enabled only when watchdog node is opened
* dynamic wdt structure, which potentially simplifies future support of
  several watchdogs found on imx51 and imx37 IIRC
* no critical message on close with unset NOWAYOUT on non-imx1 SoCs

Your pretty good version supports imx1, and I cann't test my version on
imx1, because I don't have such hardware on hand.

Obviously better to update your reviewed one, and I hope some comments or even
updates from my side could be accepted by you :)

With best wishes,
Vladimir
