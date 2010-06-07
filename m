From: dhylands@gmail.com (Dave Hylands)
Date: Mon, 7 Jun 2010 13:11:17 -0700
Subject: Question about SMP
Message-ID: <AANLkTilJOUmarsLJJtNzbVwrZLbLAD29gp2SHL0TZCUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

(filled in subject line this time - Doh).

I'm trying to understand what I need to be concerned about with SMP
processors and sharing global data (in particular a dual Cortex-A9)

I'm familiar with spinlocks, but in this case I'm trying to work with
some lockless data structures.

What I'm not sure is whether the following would work. Suppose I have
a couple of 8-bit get/put indicies which are in adjacent memory
locations (within the same 32-bit word).

If I have an ISR and a thread running on an SMP core, and the ISR is
running on one core and the thread is running on a second core, if the
ISR were to only write to the put pointer and the thread were only to
write to the get pointer, does the cache maintain consistency? Or do
the get and put pointers need to be in separate cache lines?

Another way of asking this: If both cores are writing to the same
32-bit word (but different bytes) do the writes collide?

--
Dave Hylands
Shuswap, BC, Canada
http://www.DaveHylands.com/
