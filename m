From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 12 Mar 2012 22:07:34 -0400
Subject: ARM926EJS boot failure on v3.3, __iounmap
In-Reply-To: <CAKON4OyURmGP79oJaCkAw1dx3orynZDZSqZOC_t=PTKwHWaRJQ@mail.gmail.com>
References: <CAKON4OzL9HtF+3bxzC9zexd7QgAFd5R7Wr=QTShYR+Kk1b4L+g@mail.gmail.com>
 <CAKON4OyURmGP79oJaCkAw1dx3orynZDZSqZOC_t=PTKwHWaRJQ@mail.gmail.com>
Message-ID: <20120313020734.GE5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 07:31:58PM -0400, jonsmirl at gmail.com wrote:
> The answer to this is that as of v3.3 you can't have overlapping IO
> regions. The code I was porting has a large define covering peripheral
> space and then many smaller ones inside the region, one for each
> device. I needed to delete the defines for those inner devices.

I got bit by this last week with the dreamplug (kirkwood), I worked
around it by disabling CONFIG_ARM_PATCH_PHYS_VIRT.  Could you elaborate
on your solution so I can work towards a real fix on
plat-orion/mach-kirkwood?

Thanks,

Jason.
