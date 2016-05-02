From: eric@anholt.net (Eric Anholt)
Date: Mon, 02 May 2016 08:29:30 -0700
Subject: [PATCH 2/2] clk: bcm2835: Skip PLLC clocks when deciding on a new
 clock parent
In-Reply-To: <C771F70C-2F88-49E1-A370-D76D13262C1E@martin.sperl.org>
References: <1461699585-6649-1-git-send-email-eric@anholt.net>
 <1461699585-6649-2-git-send-email-eric@anholt.net>
 <C771F70C-2F88-49E1-A370-D76D13262C1E@martin.sperl.org>
Message-ID: <878tzsiilh.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Sperl <kernel@martin.sperl.org> writes:

>> On 26.04.2016, at 21:39, Eric Anholt <eric@anholt.net> wrote:
>> 
>> If the firmware had set up a clock to source from PLLC, go along with
>> it.  But if we're looking for a new parent, we don't want to switch it
>> to PLLC because the firmware will force PLLC (and thus the AXI bus
>> clock) to different frequencies during over-temp/under-voltage,
>> without notification to Linux.
>> 
>> On my system, this moves the Linux-enabled HDMI state machine and DSI1
>> escape clock over to plld_per from pllc_per.  EMMC still ends up on
>> pllc_per, because the firmware had set it up to use that.
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
>> ?
>
> I guess this patch looks to me as if it is a policy inside the kernel,
> which is AFAIK frowned upon.

Can you come up with a use for putting peripherals on PLLC ever, such
that we need choice?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/32cf10a4/attachment.sig>
