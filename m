From: johnhlinn@gmail.com (John Linn)
Date: Tue, 7 Aug 2012 17:49:41 -0700
Subject: changing clock source frequency input for ARM kernel
Message-ID: <CAB9O=CPoMdkbnCOTreUuNZ+yHa_+8L1A4VXk6A1ODtgxoGjz7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are working on CPU frequency scaling and our clock source is
dependent on our CPU frequency. When we change the CPU frequency we'd
like to update the clock source so the time keeping is all correct.

It's not clear to use how to make this correcly. The ST mobile stuff
is the only example of calling clocksource_updatefreq() that we see,
but since it's in the enable function it's not clear that this will
help us.

We have another timer in the block that we can use to allow us to ping
pong when updating the frequency if needed, but it's still based on
the same clock which is dependent on the CPU frequency.  It seems not
wise to disable the clock source if there's only one then re-enable
it.

Thanks for any help,
John
