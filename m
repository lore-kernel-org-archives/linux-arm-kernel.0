From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 14 Jun 2011 22:43:43 -0700
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
In-Reply-To: <20110615044016.GC10553@ericsson.com>
References: <20110614190850.GA13526@linux-mips.org>
	<4DF7C3CA.9050902@zytor.com>
	<20110614223404.GA30057@linux-mips.org>
	<4DF8329C.7000904@zytor.com> <20110615044016.GC10553@ericsson.com>
Message-ID: <4DF8468F.1080806@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2011 09:40 PM, Guenter Roeck wrote:
> On Wed, Jun 15, 2011 at 12:18:36AM -0400, H. Peter Anvin wrote:
>> On 06/14/2011 03:34 PM, Ralf Baechle wrote:
>>>
>>> There is no point in offering to build something that couldn't possibly be
>>> used.  It just makes the kernel harder to configure and inflates the test
>>> matrix for no good reason.
>>>
>>
>> I see... that's why a bunch of devices that only exist on ARM and MIPS
>> SoCs are offered on x86 platforms?
>>
> http://en.wikipedia.org/wiki/Two_wrongs_make_a_right
> 

Except in this case it's not wrong.  It was done that way because it was
discovered a long time ago that restricting drivers that were not
*inherently* limited to specific platform just resulted in more bitrot
and nasty surprises for the users who *did* need specific things after
all, even though the maintainers had not thought so.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
