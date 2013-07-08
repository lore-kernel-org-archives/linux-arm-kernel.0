From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Jul 2013 12:02:02 +0100
Subject: v3.10 - big endian core support
In-Reply-To: <51DA8BBF.7080104@gmail.com>
References: <1372676648-9254-1-git-send-email-ben.dooks@codethink.co.uk>
 <51DA5089.5080109@gmail.com>
 <20130708084911.GA22057@mudshark.cambridge.arm.com>
 <51DA8BBF.7080104@gmail.com>
Message-ID: <20130708110202.GD22057@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 10:51:59AM +0100, jgq516 at gmail.com wrote:
> On 07/08/2013 04:49 PM, Will Deacon wrote:
> > Well, I hacked head.S recently to fix booting with LPAE and BE8, but I was
> > unable to test early console since I was using virtio-console. It could be
> > that the page table entries mapping the uart aren't quite right, but no
> > obvious issues jump out from looking at the code.
> Good to know you tried LPAE and BE8, and I can test the hack code if you 
> wish.

The hack got merged, since it fixed booting (which I managed to test), I
just couldn't test earlyprintk. Maybe I can try and get something up and
running on the model.

> > How much visibility do you have on your platform?
> The printascii can output before "b __enable_mmu", after move it to
> __mmap_switched, nothing can be printed. But if disable LPAE, printascii
> works again in __mmap_switched.

Ok, so the page tables are broken. The code is there to swap the two words,
but perhaps something ends up being off-by-4 or the like. I'll try and take
a look.

Will
