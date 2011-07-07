From: bryan.wu@canonical.com (Bryan Wu)
Date: Thu, 7 Jul 2011 20:54:25 +0800
Subject: [PATCH 00/17] Introduce a led trigger for CPU activity
In-Reply-To: <20110706131600.GW8286@n2100.arm.linux.org.uk>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<CAMPhdO-Ln7BmU8jYfEEp3RPa9sgJueTVfsm1phs=NXTC3FPgNw@mail.gmail.com>
	<20110706131600.GW8286@n2100.arm.linux.org.uk>
Message-ID: <CAK5ve-L02jEjQBKaL5+YzUev4znATx=ELp-kZZQiFtF3afo4QQ@mail.gmail.com>
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

I chose the 'heartbeat' and 'cpu' triggers as default triggers of
Assabet 2 LEDs.
+/*
+ * The triggers lines up below will only be used if the
+ * LED triggers are compiled in.
+ */
+static const struct {
+       const char *name;
+       const char *trigger;
+} assabet_leds[] = {
+       { "assabet:red", "cpu",},
+       { "assabet:green", "heartbeat", },
+};

But it can be changed on the fly via sysfs. Does this replacement make sense?

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
