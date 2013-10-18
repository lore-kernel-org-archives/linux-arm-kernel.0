From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 18 Oct 2013 19:27:29 +0200
Subject: [PATCH] ARM: kirkwood: remove lagacy clk workarounds
In-Reply-To: <20131018161743.GA29595@localhost>
References: <1382097253-15624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131018144741.GL22434@titan.lakedaemon.net>
 <20131018161743.GA29595@localhost>
Message-ID: <52616F81.8060504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2013 06:17 PM, Ezequiel Garcia wrote:
> On Fri, Oct 18, 2013 at 10:47:41AM -0400, Jason Cooper wrote:
>> On Fri, Oct 18, 2013 at 01:54:13PM +0200, Sebastian Hesselbarth wrote:
>>> With legacy devices converted to DT and a proper ethernet MAC
>>> workaround, we can now remove the clk workarounds for legacy
>>> devices. While at it, also cleanup the list of includes.
>>>
>>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>> ---
>>> As a follow-up patch for latest mvebu PRs, this patch is based on
>>>   git://git.infradead.org/linux-mvebu.git tags/soc-3.13-2
>>>
>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>> Cc: Andrew Lunn <andrew@lunn.ch>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Cc: Kevin Hilman <khilman@linaro.org>
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: linux-kernel at vger.kernel.org
>>> ---
>>>   arch/arm/mach-kirkwood/board-dt.c |   42 ++----------------------------------
>>>   1 files changed, 3 insertions(+), 39 deletions(-)
>>
>> Applied to mvebu/soc
>>
>
> Weird: I've tried to do this clean-up myself and my usual tests with network
> built as a module failed somehow. Maybe I missed something and did something
> stupid?

Ezequiel,

you need commits
b5d82db net: mv643xx_eth: fix missing device_node for port devices
f564412 net: mv643xx_eth: fix orphaned statistics timer crash
041b4dd net: mv643xx_eth: update statistics timer from timer context only

from git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git master

Those are the three net driver fixes and have not yet been pulled into
mainline linux.

Can you re-test with those three applied (or you can just merge in
above master)? I am compiling right now and will report.

Sebastian
