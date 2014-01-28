From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 28 Jan 2014 12:40:48 +0200
Subject: [PATCH] clk: divider: fix rate calculation for fractional rates
In-Reply-To: <20140128103253.GD15937@n2100.arm.linux.org.uk>
References: <1383736008-22764-1-git-send-email-tomi.valkeinen@ti.com>
 <20131106111534.GW16735@n2100.arm.linux.org.uk> <527A2C9C.4080409@ti.com>
 <20131106161911.GA16735@n2100.arm.linux.org.uk> <52E76E3A.8030807@ti.com>
 <20140128103253.GD15937@n2100.arm.linux.org.uk>
Message-ID: <52E78930.8080607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-01-28 12:32, Russell King - ARM Linux wrote:

>> Why I'm asking this is that for me (and probably for others also if
>> you've seen it used in the kernel code) it feels natural to have code like:
>>
>> 	rate = clk_round_rate(clk, rate);
>> 	
>> 	/* Verify the rounded rate here to see it's ok for the IP etc */
>>
>> 	/* The rate is ok, so set it */
>> 	clk_set_rate(clk, rate);
> 
> If you want to do something with the rounded rate, then that's fine,
> you have a reason to do it this way.  However, what I was referring to
> are drivers which literally do this:
> 
> 	clk_set_rate(clk, clk_round_rate(clk, rate));

Thanks for clarification. Agreed, that's pointless. I gave the sequence
in the patch description just as an example for the sake of discussion
about the bug.

I didn't realize people actually do that in real code =).

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140128/97c9c93c/attachment.sig>
