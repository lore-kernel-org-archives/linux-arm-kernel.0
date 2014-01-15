From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 15 Jan 2014 20:04:45 +0100
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D45C5AB@AcuExch.aculab.com>
 (David Laight's message of "Wed, 15 Jan 2014 09:59:10 +0000")
References: <87eh4dot61.fsf@natisbad.org> <87sissopaf.fsf@natisbad.org>
 <20140114170719.GA12126@xanatos> <87bnzekz5l.fsf@natisbad.org>
 <063D6719AE5E284EB5DD2968C1650D6D45C5AB@AcuExch.aculab.com>
Message-ID: <87mwix5anm.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

David Laight <David.Laight@ACULAB.COM> writes:

>> I tried current 3.13.0-rc8 w/ 35773dac5f86 reverted and the result is
>> the same:
>
> That patch only affects an error code and stops the fs code retrying
> for ever.

Are you sure? ...

> Does everything work if you comment out the code in xhci-ring.c that adds
> NOP TRBs to the ring end in order to stop the LINK TRB appearing in the middle
> of a TB.
> The ethernet code needs it, but the disk transfers are (probably) aligned
> such that they don't.

... AFAICT, this is exactly what commit 35773dac5f86 does and reverting
it does not help. If I am mistaken, can you point which part you want me
to remove in the code to test?

I am slowly starting to see a bisect session coming ;-)

Cheers,

a+
