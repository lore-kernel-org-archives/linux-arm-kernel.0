From: stefan@agner.ch (Stefan Agner)
Date: Sat, 11 Aug 2018 20:19:52 +0200
Subject: [PATCH] ARM: drop experimental mark for ARM stack unwinding
In-Reply-To: <20180811165728.GS30658@n2100.armlinux.org.uk>
References: <20180811103127.21485-1-stefan@agner.ch>
 <20180811165728.GS30658@n2100.armlinux.org.uk>
Message-ID: <9c1b118342fa64f208f66d9bf651f0e8@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.08.2018 18:57, Russell King - ARM Linux wrote:
> On Sat, Aug 11, 2018 at 12:31:27PM +0200, Stefan Agner wrote:
>> ARM stack unwinding is upstream since 2009 and has been proven
>> working well. At this time it is the preferred stack unwinding
>> support since it also supports Thumb 2. Do not scare people
>> and drop the EXPERIMENTAL mark.
> 
> Actually, there are still cases where we're missing the annotations -
> I've seen them in various oops dumps, but I forget where they are.
> What I do remember is that they didn't seem trivial to fix at the
> time, so it's still recommended that frame pointers are used if you
> want to guarantee getting a debuggable oops dump.

Ok, but does that warrants the experimental mark?

Experimental sounds rather harsh to me. People might disable it because
of that... I'd rather have a >90% chance of having a good stack trace
than none at all.

--
Stefan
