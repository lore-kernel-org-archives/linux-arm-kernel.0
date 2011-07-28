From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Jul 2011 00:40:50 -0400 (EDT)
Subject: [RFC PATCH 0/3] ARM: Add default system.h and uncompress.h
In-Reply-To: <1311823934-29553-1-git-send-email-robherring2@gmail.com>
References: <1311823934-29553-1-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.00.1107280023140.12766@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jul 2011, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> This is a relatively simple way to remove the platform requirement for
> some header files without making changes in every existing platform.
> It's perhaps not a solution for the difficult cases, but can get the
> simple cases out of the way making it clear what remains to be fixed.
> I've done this for system.h and uncompress.h so far. timex.h and io.h
> may be additional candidates.

I'm of two minds about this.  It is true that this makes things easy and 
would avoid some of the #ifdef'ery that is otherwise necessary.  On the 
other hand this gives us more opportunity for procrastinating and not 
really do a complete and thorough job.  It would also be easier for some 
platform to sneak in some of those header files to work around some 
shortcomings in the generic version which is not helping maintainers 
keeping a good discipline.  AS we are working on this, I might prefer 
that mistakes do break the build rather than silently causing a 
fallback with a dummy generic version to be picked up which might only 
cause problems at run time much later.

A Linaro event is taking place next week in England where a focused 
effort will be deployed to work on this.  Let's see how much we'll be 
able to clean up.


Nicolas
