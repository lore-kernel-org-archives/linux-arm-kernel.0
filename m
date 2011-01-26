From: davidb@codeaurora.org (David Brown)
Date: Tue, 25 Jan 2011 22:19:04 -0800
Subject: [PATCH v2 01/11] msm: Add CPU queries
In-Reply-To: <00e801cbbd11$96b3ca90$c41b5fb0$@gmu.edu> (Zhaohui Wang's message
	of "Tue, 25 Jan 2011 23:29:13 -0500")
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-2-git-send-email-davidb@codeaurora.org>
	<1295914163.29639.77.camel@c-dwalke-linux.qualcomm.com>
	<8yak4htj0lb.fsf@huya.qualcomm.com>
	<1295915034.29639.78.camel@c-dwalke-linux.qualcomm.com>
	<8yay669hka5.fsf@huya.qualcomm.com>
	<1295976910.25496.1.camel@c-dwalke-linux.qualcomm.com>
	<8ya39ogg5dm.fsf@huya.qualcomm.com>
	<1295983549.25496.33.camel@c-dwalke-linux.qualcomm.com>
	<8yaei80epie.fsf@huya.qualcomm.com>
	<1295985978.25496.35.camel@c-dwalke-linux.qualcomm.com>
	<00e801cbbd11$96b3ca90$c41b5fb0$@gmu.edu>
Message-ID: <8yafwsgchlz.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25 2011, Zhaohui Wang wrote:

> Maybe it's not appropriate to cut in your discussion.

It's quite appropriate.

> Can anyone explain what's the difference between qsd8X50 and msm8x60?
> No msm8x50, right?

Well, they're just part numbers, and the numbering isn't all that
consistent over time:
http://www.qualcomm.com/products_services/chipsets/snapdragon.html

The first snapdragon device was calls a QSD (8250 and 8660).  They are
identical as far as Linux is concerned (the modem is different).  There
is no MSM on these.  Only these two chips have used the QSD prefix.

The rest of the family went back to the original MSM prefix on the
names, most in pairs (2 and 6 in the second digit).

The names of the cpu_is macros come right off of the website above
(including the X).

The confusion is that a new chip is being called MSM8960 (web search
pulls up lots of hits about it).  Despite any possibile similarities in
the initial kernel support for this device, it is significantally
different than the MSM8660.  Even the CPU is different.

I've been debating whether to rename the msm8x60 tests to just pick one
of the devices (say msm8660) to avoid the confusion with the 8960.  That
would then, however, be confusing to someone with an MSM8260 device, so
there isn't a solid win.

The cpu_is_...() tests are the tests to distinguish which particular
chip the kernel is running on.  They are supposed to be unique, per
chip.

Classes of chips with similar features would have other tests (see
cpu_class_is_omap2()) made on top of these checks.

David

> Many thanks.
>
>
> Best Regards
> David Wange
>
>
> -----Original Message-----
> From: linux-arm-msm-owner at vger.kernel.org [mailto:linux-arm-msm-owner at vger.kernel.org] On Behalf Of Daniel Walker
> Sent: Tuesday, January 25, 2011 3:06 PM
> To: David Brown
> Cc: linux-arm-msm at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 01/11] msm: Add CPU queries
>
> On Tue, 2011-01-25 at 11:45 -0800, David Brown wrote:
>> On Tue, Jan 25 2011, Daniel Walker wrote:
>> 
>> > On Tue, 2011-01-25 at 11:17 -0800, David Brown wrote:
>> 
>> > I suggesting we do it across the board because consistency is a good 
>> > thing .. It also allows us to use 8x60 when 8660 and 8960 are 
>> > actually similar .. You can't deny that 8960 is similar to 8660 
>> > because your patches show some duplication due to it.
>> 
>> You're completely missing the point of these tests.  If _anything_ is 
>> different, the macros need to be different.  I don't care if they're 
>> similar, I need to know when they are different.  That is the point of 
>> the macros.
>
> I said you would have macros specifically for 8660 and 8960, so if you need to know when they're different then you have macro's to do that. 
>
> Daniel

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
