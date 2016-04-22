From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Apr 2016 19:41:28 +0200
Subject: [PATCH 18/25] arm64: ilp32: introduce binfmt_ilp32.c
In-Reply-To: <20160422165130.GQ2998@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-19-git-send-email-ynorov@caviumnetworks.com>
 <20160422165130.GQ2998@e104818-lin.cambridge.arm.com>
Message-ID: <5122105.YDc1h2V3NP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 April 2016 17:51:30 Catalin Marinas wrote:
> On Wed, Apr 06, 2016 at 01:08:40AM +0300, Yury Norov wrote:
> > --- /dev/null
> > +++ b/arch/arm64/kernel/binfmt_ilp32.c
> 
> [...]
> 
> > +#include "../../../fs/binfmt_elf.c"
> 
> How different is this new binfmt_ilp32.c file from the first part of
> compat_binfmt_elf.c? I wonder whether we could include the latter here
> instead and make this similar to binfmt_elf32.c introduced by the
> previous patch.

That is how the earlier versions did it, and I thought it ended up 
too ugly with lots of runtime checks instead of compile-time checks.

The current version is how I asked it to be done. A slight
variation would be to keep using fs/compat_binfmt_elf.c for one
of the two compat modes (today it is used for aarch32) and have
a separate file include "../../../fs/binfmt_elf.c" for the other
mode (as this patch does for ilp32). I think that is what I asked
for, but there was probably a good reason for having two files
in the same directory. The result is basically the same.

	Arnd
