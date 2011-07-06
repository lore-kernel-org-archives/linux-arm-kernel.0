From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 6 Jul 2011 21:19:43 +0800
Subject: [PATCH 00/17] Introduce a led trigger for CPU activity
In-Reply-To: <20110706131600.GW8286@n2100.arm.linux.org.uk>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<CAMPhdO-Ln7BmU8jYfEEp3RPa9sgJueTVfsm1phs=NXTC3FPgNw@mail.gmail.com>
	<20110706131600.GW8286@n2100.arm.linux.org.uk>
Message-ID: <CAMPhdO_w3s9ktjdT_epX0EOYZ31tTRrdaUKgQEFxRZbB2b5=XQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 6, 2011 at 9:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 06, 2011 at 09:13:14PM +0800, Eric Miao wrote:
>> > ?drivers/leds/ledtrig-cpu.c ? ? ? ? ? ? ? ? ? ? | ?144 ++++++++++++
>> > ?include/linux/leds.h ? ? ? ? ? ? ? ? ? ? ? ? ? | ? 15 ++
>> > ?105 files changed, 1532 insertions(+), 3119 deletions(-)
>>
>> Not bad, I like the numbers here. This is definitely a good move.
>> I had long ago wanted to remove those legacy LED code in mach-pxa.
>
> The down-side is that through these moves we've lost functionality each
> time. ?For example, the blinking heartbeat LED on the Assabet and
> Netwinder which I always enabled to let me know whether the machines
> were still alove has long since gone.
>
> I hope that this series restores that functionality on those platforms
> where it has been lost.
>

Yeah, I have the same concern. So probably extending the current simple
API to allow a more flexible behavior would be better.
