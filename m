From: tim.bird@am.sony.com (Tim Bird)
Date: Tue, 18 Oct 2011 17:26:44 -0700
Subject: [PATCH 0/3] ARM 4Kstacks: introduction
In-Reply-To: <1318983248.7569.5.camel@Joe-Laptop>
References: <4E9E0B71.9020708@am.sony.com> <1318983248.7569.5.camel@Joe-Laptop>
Message-ID: <4E9E1944.80601@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2011 05:14 PM, Joe Perches wrote:
> On Tue, 2011-10-18 at 16:27 -0700, Tim Bird wrote:
>> I'm about to submit a set of patches (really pretty small)
>> to add 4K stack support to ARM (defaulted to 'N').
> 
> When 4k stacks went away, I thought it safe enough
> to submit vsnprintf recursion using %pV.
> 
> I believe the current vsnprintf max recursion is 3.
> Each recursion uses at least 300 bytes of stack.
> 
> That might be some additional issue for 4k stacks.

Interesting.  Thanks very much for the heads up.
I don't know how prevalent %pV is, but I'll take a
look tomorrow and see if I think this would be an
issue.  One option would be to turn off recursion
in the 4K stacks case (but I don't know how badly
this would mangle the code).

I'm not sure I'm willing to advocate eliminating
all occurrences of high stack usage in the kernel.
It seems like this would generate a lot of friction
for getting this mainlined.  As long as I can document
the trouble that people might get in when they
turn this on, I think that would be very good.

Even inside Sony, usage of 4K stacks is limited
to some very special cases, where memory is exceedingly
tight (we have one system with 4M of RAM).  And we
don't mind lopping off features or coding around
problem areas to support our special case.

Thanks again for the notice.
 -- Tim


=============================
Tim Bird
Architecture Group Chair, CE Workgroup of the Linux Foundation
Senior Staff Engineer, Sony Network Entertainment
=============================
