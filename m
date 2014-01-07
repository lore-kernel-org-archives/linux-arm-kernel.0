From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 7 Jan 2014 12:24:14 +0100
Subject: [GIT PULL] get rid of <mach/timex.h>
In-Reply-To: <20131220184715.GT14866@pengutronix.de>
References: <20131213221651.GA10344@perseus.defre.xn--kleine-knig-yfb.de>
 <87bo0clved.fsf@linaro.org> <20131219221758.GS14866@pengutronix.de>
 <20131220184715.GT14866@pengutronix.de>
Message-ID: <52CBE3DE.5010706@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/12/2013 19:47, Uwe Kleine-K?nig :
> Hello again,
> 
> On Thu, Dec 19, 2013 at 11:17:58PM +0100, Uwe Kleine-K?nig wrote:
>> On Thu, Dec 19, 2013 at 07:20:42AM -0800, Kevin Hilman wrote:
>>> Looks like there are still several users of LATCH, which references CLOCK_TICK_RATE
>>> and is causing failures on lots of defconfigs.
>> darn, I missed these because my compile testing was done without
>> removing the dummy value of CLOCK_TICK_RATE in <asm/timex.h> and I then
>> relied on the 0day bot who obviously didn't build the critical configs.
>> :-\
>>
>> The problems are fixed by:
>>  - "ARM: rpc: stop using <mach/timex.h>" which I just sent in this
>>    thread.
>>  - "ARM: u300: fix timekeeping when periodic mode is used", a patch I
>>    sent earlier and that Linus W. wanted to merge. It's not yet in
>>    -next. Maybe I can take it instead into this series? Linus?
>>  - The patch pasted below distributed on the respective commits.
>>    Apart from the netx patch these don't have any affected acks. Sascha,
>>    I assume I can keep your Ack?
>>
>> I'll update my tree when I have feedback by Linus and Sascha.
> I just did that. I squashed the changes into the respective commits,
> rebased on Linus W.'s latest pull request and added the rpc change. Now
> all defconfigs build.
> 
> Please pull
> 
> 	git://git.pengutronix.de/git/ukl/linux.git tags/dropmachtimexh
> 
> which points to 79f08d9ed217318b4f325b7fcf8f26dcd0e41689 now provided
> you are happy with Linus W.'s series, too.

Hi all,

Is this pull-request is foreseen to be integrated in arm-soc for 3.14? I
may have some material for Linus W. that I would like to queue that
depend on these patches.

Bye,
-- 
Nicolas Ferre
