From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Oct 2014 22:31:07 +0200
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <20141023161220.GK27405@n2100.arm.linux.org.uk>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
 <5876859.V209eoUfHk@wuerfel> <20141023161220.GK27405@n2100.arm.linux.org.uk>
Message-ID: <3345399.JKaCjH1LWX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 October 2014 17:12:20 Russell King - ARM Linux wrote:
> 
> > I haven't found the code in gcc that performs the type check for
> > printf, but I've found a comment about that code intentionally
> > resolving the type (printing 'unsigned int') when the typedef
> > does not match the expected type.
> 
> If I had a copy of the GCC 4.9 source locally, I'd dig into it too and
> try to work out what's going on.  My gut feeling is that it's a bug in
> GCC rather than something which the kernel is doing wrong.
> 

I suspect it has something to do with the way that Olof's gcc is built,
since it doesn't happen for me using the same kernel source and gcc-4.9.1
or 4.10-prerelease.

The fact that it doesn't define __linux__ means that it must be configured
in some other way than what I do or what I get from the distros.

	Arnd
