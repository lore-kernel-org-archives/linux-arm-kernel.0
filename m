From: arasv@magellan-technology.com (Aras Vaichas)
Date: Thu, 28 Oct 2010 14:14:19 +1100
Subject: at91: input overruns question
In-Reply-To: <AANLkTinbThMFXd1KpuMRYNJREpjGa6RNBH9R1SM955Sd@mail.gmail.com>
References: <AANLkTinbThMFXd1KpuMRYNJREpjGa6RNBH9R1SM955Sd@mail.gmail.com>
Message-ID: <AANLkTimHnxLydJC3u58kAuukjR80EEgRDj7ZEedNMKfd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 October 2010 17:19, Aras Vaichas <arasv@magellan-technology.com> wrote:
> Hi,
>
> I'm updating our production kernel to 2.6.33.7-rt29 for an at91rm9200.
> This is the newest version supported by RT.
>
> I've noticed that the age-old debug serial input overrun(s) issue has
> gotten far worse and I can no longer use the cursor keys at all. i.e.
> no history on serial console or vi.
>
> As the kernel version numbers have gone up, the problem seems to have
> gotten worse.
>
> Is there anything that I can do to make it a bit more usable?
>
> Any .config changes?

Configuration settings CONFIG_NO_HZ and CONFIG_HIGH_RES_TIMERS cause
the overrun(s) problems to get worse.

If I disable these two settings I still get overrun(s) but not quite
as frequent.

Can someone explain why these settings would cause the CPU to be
unable to process 2 serial characters in a row?

Something must be causing the DBGU serial receive interrupt to stall
for more than 86us in order to miss a complete 115200 baud serial
character.

Aras
