From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Oct 2013 14:23:21 +0100
Subject: [PATCH 3/4] ARM: msm: Remove 7x30 supporty
In-Reply-To: <20131029211554.GA16284@fifo99.com>
References: <1382993006-27359-1-git-send-email-davidb@codeaurora.org>
 <1382993006-27359-4-git-send-email-davidb@codeaurora.org>
 <20131029211554.GA16284@fifo99.com>
Message-ID: <201310301423.21711.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 October 2013, Daniel Walker wrote:
> Why wouldn't you just update it to use the device tree ? There are lots
> of phones our there using 7x30 .. 
> 
> This is one that Qualcomm specifically upstreamed, so what was the point
> of upstreaming it ?

Things like this happen a lot: you start with great ambitions, then real
life takes over and everybody who was once working on it has moved on to
other projects before the code actually works. 

We have the policy to let new code for incomplete platforms into the
tree very liberally, but the flip side is that we have to remove them
as swiftly if progress stops. Note that this is completely different
from most of the older platforms like the StrongARM based machines
that are way more outdated but are actually working just fine and
getting fixed when they don't.

The MSM platform is currently a mess with most SoCs broken most of 
the time. I definitely agree with David's approach of removing the
ones that are not being worked on and finally getting the newer ones
to work properly, and on the same level as the other platforms.

Once that work is complete, adding back support for the older SoCs
should become much easier if anyone is still interested, since the
required changes (multiplatform, DT, ...) are targetted at reducing
the effort of maintaining platforms.

	Arnd
