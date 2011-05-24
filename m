From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 24 May 2011 15:17:18 +0100
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
References: <20110523111648.10474.78396.stgit@e102109-lin.cambridge.arm.com>
	<20110523132124.GI17672@n2100.arm.linux.org.uk>
	<1306229953.19557.14.camel@e102109-lin.cambridge.arm.com>
Message-ID: <yw1xipt0p4i9.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, 2011-05-23 at 14:21 +0100, Russell King - ARM Linux wrote:
>> On Mon, May 23, 2011 at 12:16:48PM +0100, Catalin Marinas wrote:
>> > Newer versions of gcc generate unaligned accesses by default, causing
>> > kernel panics when CONFIG_ALIGNMENT_TRAP is enabled. This patch adds the
>> > -mno-unaligned-access option to gcc.
>> 
>> This description doesn't make sense.  If we have alignment traps enabled,
>> then we _expect_ to fix up unaligned loads and stores.
>> 
>> Therefore there should be no panic if CONFIG_ALIGNMENT_TRAP is enabled.
>> 
>> So what's the _actual_ problem that this is trying to address?  What's
>> the panic/oops look like?  And that information should be in the commit
>> description _anyway_.
>
> Does the patch below look better?
>
> We cannot move alignment_init() earlier as we don't know how early the
> compiler would generate unaligned accesses. An alternative is some
> #ifdef's in head.S. Please let me know which variant you prefer.

ifdefs may be ugly, but I don't see a better solution here.  Crippling
the entire build to make a couple of lines slightly more aesthetically
pleasing doesn't seem right to me.

-- 
M?ns Rullg?rd
mans at mansr.com
