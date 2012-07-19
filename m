From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 19 Jul 2012 15:07:42 -0400 (EDT)
Subject: are there PHYS_OFFSET alignment requirements for ARM Linux?
In-Reply-To: <CAB9O=CN_aDFTb7GVv++bMXPYS_RjEZe3NUeZY5uX1+mebTVKcA@mail.gmail.com>
References: <CAB9O=CN_aDFTb7GVv++bMXPYS_RjEZe3NUeZY5uX1+mebTVKcA@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1207191501330.9293@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Jul 2012, John Linn wrote:

> I have seen some mention of 2 MB alignment requirements, but it's not
> clear to me if that's true or not (looks old)?
> 
> My apologies if it's obvious somewhere, but are there any alignment
> requirements?

There is a 2MB alignment requirement on PHYS_OFFSET.  You may play 
tricks with memory reservation if a smaller offset is required, but I'd 
recommend against that.  Even 2MB is too small an alignment if you want 
to have CONFIG_ARM_PATCH_PHYS_VIRT=y (the default) which requires a 16MB 
alignment.

It is very exceptional to see systems where RAM is not aligned to a much 
bigger boundary.  Why would you need a 2MB alignment?


Nicolas
