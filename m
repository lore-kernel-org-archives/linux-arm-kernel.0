From: ne@erfurth.eu (Nico Erfurth)
Date: Fri, 15 Apr 2011 04:59:28 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110414120209.GG1611@n2100.arm.linux.org.uk>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>	<20110414110854.GF29938@atomide.com>
	<20110414120209.GG1611@n2100.arm.linux.org.uk>
Message-ID: <4DA7B490.3020804@erfurth.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.04.11 14:02, Russell King - ARM Linux wrote:

>> It's going to take some time before the consolidated code starts
>> being available.. And until we have something available, we all
>> should aim for negative diffstat.
> 
> I think we've already lost any hope of a negative diffstat - with 6k new
> lines, we will need a heck of a lot of consolidation to counter that.

I've just skipped through the board-files in mach-at91, there is a lot
of potential for consolidation. But the big problem could be to find
people who can test it afterwards. It would also result in a bunch of
large commits. For an example, I've merged board-usb-a9260.c and
board-usb-a9263.c into board-usb-a926x.c

Result:
 arch/arm/mach-at91/board-usb-a9260.c |  236 --------------------------
 arch/arm/mach-at91/board-usb-a9263.c |  252 ---------------------------
 arch/arm/mach-at91/board-usb-a926x.c |  310
++++++++++++++++++++++++++++++++++
 3 files changed, 310 insertions(+), 488 deletions(-)

In the end, the total LOC is a lot smaller, but the changeset itself
"looks" big.

There are a lot more examples in the arch/arm/mach-* namespaces. Like
mach-kirkwood where {sheevaplug,guruplug,dockstart}-setup.c could be
easily merged together.

Nico
