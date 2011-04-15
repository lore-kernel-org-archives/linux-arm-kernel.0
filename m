From: ne@erfurth.eu (Nico Erfurth)
Date: Fri, 15 Apr 2011 15:13:14 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <4DA8000F.7000108@atmel.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>	<20110414110854.GF29938@atomide.com>	<20110414120209.GG1611@n2100.arm.linux.org.uk>	<4DA7B490.3020804@erfurth.eu>
	<4DA8000F.7000108@atmel.com>
Message-ID: <4DA8446A.4070006@erfurth.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.04.11 10:21, Nicolas Ferre wrote:

>>> I think we've already lost any hope of a negative diffstat - with 6k new
>>> lines, we will need a heck of a lot of consolidation to counter that.
>>
>> I've just skipped through the board-files in mach-at91, there is a lot
>> of potential for consolidation. But the big problem could be to find
>> people who can test it afterwards.
> 
> My opinion is that you can do the improvement and propose it to the
> community. I guess that the maintainer of the board will take your
> improvements and tests them.

We'll see, most of the board-files in mach-at91 tree are pretty old and
for hardware which is not built anymore. ;)

>> It would also result in a bunch of
>> large commits. For an example, I've merged board-usb-a9260.c and
>> board-usb-a9263.c into board-usb-a926x.c
>>
>> Result:
>>  arch/arm/mach-at91/board-usb-a9260.c |  236 --------------------------
>>  arch/arm/mach-at91/board-usb-a9263.c |  252 ---------------------------
>>  arch/arm/mach-at91/board-usb-a926x.c |  310
>> ++++++++++++++++++++++++++++++++++
>>  3 files changed, 310 insertions(+), 488 deletions(-)
> 
> Nice work!
> 
> So, anyway, even if the board maintainer is not testing, our at91
> maintainer's view of it is that the move has to be done so we will
> certainly merge it...
> 
>> In the end, the total LOC is a lot smaller, but the changeset itself
>> "looks" big.
> 
> If it is consolidation work, it is ok.

Ok, I'll clean up the patch and send it in 2-3 days.

Nico
