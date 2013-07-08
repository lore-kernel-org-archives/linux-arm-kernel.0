From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Jul 2013 09:49:11 +0100
Subject: v3.10 - big endian core support
In-Reply-To: <51DA5089.5080109@gmail.com>
References: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
 <51DA5089.5080109@gmail.com>
Message-ID: <20130708084911.GA22057@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 06:39:21AM +0100, jgq516 at gmail.com wrote:
> On 07/01/2013 07:03 PM, Ben Dooks wrote:
> > The latest big-endian changes, now on:
> >
> > 	git://git.baserock.org/delta/linux baserock/311/be/core
> >
> > This has a minor fix from the last version where a rebase missed a change
> > in the smp_scu code.
> >
> Hello Ben,
> 
> Thanks for you patches at first. I can boot BE kernel on vexpress a15 tc2
> board with LPAE disabled.
> 
> However if enable LPAE, kernel seems hang after turn on mmu on since
> printascii can't output any character in __mmap_switched.
> Did you happen to try BE kernel with LPAE enabled before? or am I missed
> something?

Well, I hacked head.S recently to fix booting with LPAE and BE8, but I was
unable to test early console since I was using virtio-console. It could be
that the page table entries mapping the uart aren't quite right, but no
obvious issues jump out from looking at the code.

How much visibility do you have on your platform? Can you take a look at the
page table entries and check they look ok please?

Cheers,

Will
