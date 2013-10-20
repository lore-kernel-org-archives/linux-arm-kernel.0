From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sun, 20 Oct 2013 23:21:35 +0100
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution,
 or is there something better?
In-Reply-To: <20131020220839.GT2443@sirena.org.uk>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk>
Message-ID: <5264576F.6050307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2013 11:08 PM, Mark Brown wrote:
> On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:
> 
>> IIRC (and perhaps I don't; it was really slightly before my
>> active involvement in kernel development) Linus triggered the
>> whole ARM DT conversion in response to disliking the volume of
>> changes, and conflicts, in board files. The idea of DT conversion
>> being that all the board-specific details could be moved out of
>> the kernel and into DT files, thus causing him not to have to see
>> it.
> 
> A large part of this was to do with the needs of distros and their
> users - they have a strong need to ship a device neutral kernel and
> to have a reasonable ability to have their kernel deploy on
> hardware unknown to them.  Allowing the device tree to be delivered
> with the system rather than have the board configuration in the
> kernel helps achieve that goal.

Yes.

I guess one thing I didn't make clear was my hope that whatever
firmware API or VM host implementation exists would be pre-installed
on the system so that distros never had to deal with it, or even know
it existed. That would then transform the many different HW
configurations into a single HW configuration as far as distros are
concerned, since they only target running as firmware clients or VM
guests. Essentially, we are creating a standard platform in SW, which
perhaps is still possible, rather than in HW, which seems unlikely at
present.
