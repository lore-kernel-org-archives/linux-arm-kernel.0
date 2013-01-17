From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Jan 2013 15:09:30 -0700
Subject: [PATCH] [RFC] ARM: compile fix for DEBUG_LL=y && MMU=n
In-Reply-To: <20130117161433.GL8668@pengutronix.de>
References: <1358346726-27199-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130116223144.GA9071@quad.lixom.net> <20130117161433.GL8668@pengutronix.de>
Message-ID: <50F8769A.7090807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2013 09:14 AM, Uwe Kleine-K?nig wrote:
> On Wed, Jan 16, 2013 at 02:31:44PM -0800, Olof Johansson wrote:
>> On Wed, Jan 16, 2013 at 03:32:06PM +0100, Uwe Kleine-K?nig wrote:
>>> debug_ll_addr is only used on machines with an MMU so it can be #ifdef'ed
>>> out safely. This fixes:
...
>> Adding a defconfig for a !MMU platform seems like a good idea, since there's
>> several of us who make sure that there is build coverage of the defconfigs and
>> follow up on most of the breakage. Feel free to send one in for 3.9.
>
> Jonny just pointed out in irc that there is at91x40_defconfig.

Ah. I have built that a few times recently, but since it doesn't enable
DEBUG_LL, this problem didn't show up.
