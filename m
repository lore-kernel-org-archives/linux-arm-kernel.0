From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 30 Mar 2010 12:41:31 +0100
Subject: [RFC 07/10] arm: allow passing an ELF64 header to elf_check_arch()
In-Reply-To: <20100330072632.GE31448@esdhcp04058.research.nokia.com>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<01f3321661bf5d6fc4ba83a0e9fdaf99a7673abc.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<20100329234124.GF9876@shareable.org>
	<20100330072632.GE31448@esdhcp04058.research.nokia.com>
Message-ID: <20100330114131.GD27463@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mika Westerberg wrote:
> On Tue, Mar 30, 2010 at 01:41:24AM +0200, ext Jamie Lokier wrote:
> > Wouldn't it be better to just disable the elf64 code entirely on
> > 32-bit archs, saving about half of the code size in vmcore.c which
> > looks like it will never be called?
> 
> I took this approach from the other architectures that implement kdump.
> 
> At least on those archs that support both 32 and 64-bit both versions should be
> supported. But I can add the required #ifdefs to vmcore code if preferred.

Ok, copying the other archs makes sense.  Someone can trim vmcore.c in
a separate patch later and tidy up the archs while they're at it.
(I've put it on my todo list but I rarely actually do the things on it...)

-- Jamie
