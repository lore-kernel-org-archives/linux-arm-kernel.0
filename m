From: tim.bird@am.sony.com (Tim Bird)
Date: Wed, 19 Oct 2011 16:43:21 -0700
Subject: [PATCH 0/3] ARM 4Kstacks: introduction
In-Reply-To: <1318984301.7569.9.camel@Joe-Laptop>
References: <4E9E0B71.9020708@am.sony.com>	
	<1318983248.7569.5.camel@Joe-Laptop> <4E9E1944.80601@am.sony.com>
	<1318984301.7569.9.camel@Joe-Laptop>
Message-ID: <4E9F6099.20904@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2011 05:31 PM, Joe Perches wrote:
> On Tue, 2011-10-18 at 17:26 -0700, Tim Bird wrote:
>> On 10/18/2011 05:14 PM, Joe Perches wrote:
>>> On Tue, 2011-10-18 at 16:27 -0700, Tim Bird wrote:
>>>> I'm about to submit a set of patches (really pretty small)
>>>> to add 4K stack support to ARM (defaulted to 'N').
>>> When 4k stacks went away, I thought it safe enough
>>> to submit vsnprintf recursion using %pV.
>> Even inside Sony, usage of 4K stacks is limited
>> to some very special cases, where memory is exceedingly
>> tight (we have one system with 4M of RAM).  And we
>> don't mind lopping off features or coding around
>> problem areas to support our special case.
> 
> I believe CONFIG_PRINTK=n assures no %pV problem.

Indeed. Hehe. :-)  We might already be doing that in
the places we're using this.

Actually, this recursion is interesting.
My stack_size tool to detects stack usage for one instance
of a function.  But it would be easy to add a special
case to do a multiplier for functions known to potentially
recurse.  I'll have to look at that and maybe add something.

Relatedly, it might be interesting to augment the static
analysis with runtime information from the stack tracer.
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Workgroup of the Linux Foundation
Senior Staff Engineer, Sony Network Entertainment
=============================
