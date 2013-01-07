From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 07 Jan 2013 21:48:13 +0100
Subject: [PATCH V2] arm: mvebu: Improve the SMP support of the interrupt
 controller
In-Reply-To: <20130107175123.GO5075@titan.lakedaemon.net>
References: <1354740203-26665-1-git-send-email-gregory.clement@free-electrons.com>
 <20130107175123.GO5075@titan.lakedaemon.net>
Message-ID: <50EB348D.8000607@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/2013 06:51 PM, Jason Cooper wrote:
> On Wed, Dec 05, 2012 at 09:43:23PM +0100, Gregory CLEMENT wrote:
>> This patch makes the interrupt controller driver more SMP aware for
>> the Armada XP SoCs. It adds the support for the per-CPU irq. It also
>> adds the implementation for the set_affinity hook.
>>
>> Patch initialy wrote by Yehuda Yitschak and reworked by Gregory
>> CLEMENT.
>>
>> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/armada-xp.dtsi        |    2 +-
>>  arch/arm/mach-mvebu/irq-armada-370-xp.c |   52 +++++++++++++++++++++++++++++++
>>  2 files changed, 53 insertions(+), 1 deletion(-)
> 
> Applied to mvebu/boards

Hi Jason,
thanks for taking this patch. Unfortunately it won't be enough. Indeed
after speaking with Marvell engineers we realized that the MPIC didn't
work as we expected. As it is written in the following patch: the MPIC,
unlike the GIC, allows several CPUs to acknowledge the same global
interrupt.

I joined the patch to this email, you can apply it on top of your
mvebu/boards or you can squash it with the previous patch.

Thanks,

Gregory
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-arm-mvebu-Fix-interrupt-handling-in-SMP-mode.patch
Type: text/x-diff
Size: 2305 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130107/c54c135b/attachment.bin>
