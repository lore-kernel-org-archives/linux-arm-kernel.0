From: trd@45mercystreet.com (Toby Douglass)
Date: Fri, 06 Nov 2009 20:10:13 +0100
Subject: GCC built-in atomic operations and memory barriers
In-Reply-To: <20091104210300.GD518@n2100.arm.linux.org.uk>
References: <4AF1C361.8090405@45mercystreet.com>
	<20091104190544.GA518@n2100.arm.linux.org.uk>
	<4AF1E01A.2010209@45mercystreet.com>
	<20091104210300.GD518@n2100.arm.linux.org.uk>
Message-ID: <4AF47495.4040109@45mercystreet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Nov 04, 2009 at 09:12:10PM +0100, Toby Douglass wrote:

[snip]

>> The "mov %0, #0" - why is this inbetween the ldrex and strexeq?  it
>> seems to me it could just as well happen before the ldrex, and doing so
>> would reduce the time between the ldrex and strexeq and so reduce the
>> chance of someone else modifying our target.
> 
> Because it probably doesn't.  Loads normally have a 'result delay' which
> cause a pipeline stall when the result is used in the next instruction.
> It makes sense to fill those stall cycles with useful work, rather than
> stalling the execution pipeline.

Thanks, Russell.  I was concerned there was something functionally 
important I'd missed with regard to the atomic op.
