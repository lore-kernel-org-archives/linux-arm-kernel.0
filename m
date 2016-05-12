From: kernel@martin.sperl.org (Martin Sperl)
Date: Thu, 12 May 2016 21:46:17 +0200
Subject: [PATCH 0/4] add minimal bcm2835-sdram driver
In-Reply-To: <87twi39m80.fsf@eliezer.anholt.net>
References: <1463056732-5607-1-git-send-email-kernel@martin.sperl.org>
 <87twi39m80.fsf@eliezer.anholt.net>
Message-ID: <BF982CDB-28CF-4AB3-BC4B-E1D88F34E72A@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 12.05.2016, at 20:15, Eric Anholt <eric@anholt.net> wrote:
> 
> kernel at martin.sperl.org writes:
> 
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> As the sdram clock is a critical clock to the system
>> the minimal bcm2835-sdram driver claims (and enables)
>> this clock and also exposes the corresponding sdram
>> registers via debugfs.
> 
> I don't think this is a good solution to the problem you are trying to
> work around.  You're relying on the fact that this driver gets
> successfully probed before a driver that would -EPROBE_DEFER on a
> sibling clock, which is not a guarantee.
Ah - that is probably the reason why hand_off has not gone in...

> 
> Let's please continue the debugging of clock management on linux-clk.

I am just trying to find a solution that works...

Still I think that having a driver that claims the clock and register range
is good to have - at least this way we can have a peek at what
the firmware does set up.
