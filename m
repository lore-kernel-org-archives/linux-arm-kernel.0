From: robherring2@gmail.com (Rob Herring)
Date: Thu, 28 Jul 2011 08:53:12 -0500
Subject: [RFC PATCH 0/3] ARM: Add default system.h and uncompress.h
In-Reply-To: <alpine.LFD.2.00.1107280023140.12766@xanadu.home>
References: <1311823934-29553-1-git-send-email-robherring2@gmail.com>
	<alpine.LFD.2.00.1107280023140.12766@xanadu.home>
Message-ID: <4E3169C8.2060406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

On 07/27/2011 11:40 PM, Nicolas Pitre wrote:
> On Wed, 27 Jul 2011, Rob Herring wrote:
> 
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This is a relatively simple way to remove the platform requirement for
>> some header files without making changes in every existing platform.
>> It's perhaps not a solution for the difficult cases, but can get the
>> simple cases out of the way making it clear what remains to be fixed.
>> I've done this for system.h and uncompress.h so far. timex.h and io.h
>> may be additional candidates.
> 
> I'm of two minds about this.  It is true that this makes things easy and 
> would avoid some of the #ifdef'ery that is otherwise necessary.  On the 
> other hand this gives us more opportunity for procrastinating and not 
> really do a complete and thorough job.  It would also be easier for some 
> platform to sneak in some of those header files to work around some 
> shortcomings in the generic version which is not helping maintainers 
> keeping a good discipline.  AS we are working on this, I might prefer 
> that mistakes do break the build rather than silently causing a 
> fallback with a dummy generic version to be picked up which might only 
> cause problems at run time much later.
> 
I just threw this out as an option.

I certainly view this as somewhat temporary, but just longer lived than
a single patch series and simpler that a bunch of temporary
HAVE_FOO_HEADER defines. Ultimately, the headers could just get rolled
into their parent asm header once all the platforms are converted over.
I don't view it as procrastinating, but allows platforms to be cleaned
up independently and spreads the work to others. The decision to move
gpio code into drivers/gpio is a good example. There was clear path and
it all went very quickly. It also allows focusing on the harder problems
while people are F2F.

> A Linaro event is taking place next week in England where a focused 
> effort will be deployed to work on this.  Let's see how much we'll be 
> able to clean up.
> 
Yes, I'm well aware of that. I'll participate remotely as much as I can.
Let me know how I can help.

Rob
