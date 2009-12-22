From: dave.korn.cygwin@googlemail.com (Dave Korn)
Date: Tue, 22 Dec 2009 14:09:02 +0000
Subject: [PATCH] ARM: Convert BUG() to use unreachable()
In-Reply-To: <20091221201059.GD11669@n2100.arm.linux.org.uk>
References: <1260266138-17684-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091217150120.GD24967@shareable.org>
	<4B2A65C6.7080009@caviumnetworks.com>
	<84fc9c000912170917y4b2772d0n47bb4dabc74b91ef@mail.gmail.com>
	<20091217181718.GA4440@n2100.arm.linux.org.uk>
	<4B2FCCE3.1090209@redhat.com>
	<20091221201059.GD11669@n2100.arm.linux.org.uk>
Message-ID: <4B30D2FE.9020209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Dec 21, 2009 at 11:30:43AM -0800, Richard Henderson wrote:
>> On 12/17/2009 10:17 AM, Russell King - ARM Linux wrote:
>>> How is "size-optimal trap" defined?
>> E.g. Sparc and MIPS have "tcc" instructions that trap based on the
>> condition codes, and so we eliminate the branch.  That's the only
>> optimization we apply with __builtin_trap.
>>
>>> Let me put it another way: I want this function to terminate with an
>>> explicit NULL pointer dereference in every case.
>> Then just use that.
> 
> That's precisely what we have been using for many years.

  I don't understand.  It should still work just fine; the original version
posted appears to simply lack 'volatile' on the (int *) cast.

    cheers,
      DaveK
