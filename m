From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sun, 15 Oct 2017 00:50:42 +0300
Subject: ARM: pxa/corgi: armv5te kernel 4.12 fails to decompress compiled
 with gcc7
In-Reply-To: <CAAQYJAtEmJMc766kUx+bhFCNQKmwK53nSDNL0nFz-9UXSUO5CQ@mail.gmail.com>
References: <CAAQYJAvR2_wqf2Axe4aVMOu08t7w5tNEjK0s3fw_oemtqCRo7g@mail.gmail.com>
 <87a83zsiid.fsf@belgarion.home>
 <CAAQYJAtEmJMc766kUx+bhFCNQKmwK53nSDNL0nFz-9UXSUO5CQ@mail.gmail.com>
Message-ID: <20171014215042.kfrhb2kjhm7wb7vb@darkstar.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Sep 02, 2017 at 11:50:55PM +0200, Andrea Adami wrote:
> On Thu, Jul 20, 2017 at 8:57 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> > Andrea Adami <andrea.adami@gmail.com> writes:
> > I have the same report on userspace side on buildroot from Petr [1], which
> > triggers endless segfaults in userspace (init) with gcc7 while everything is
> > fine with gcc6. I have confirmation on my test farm the problem happens as well.
> >
> > Since debugging in userspace is far easier, I would suggest attacking the debug
> > with Petr on userspace side, and once sorted out, come back to kernel side.
> 
> sorry for the delay, I was awaiting to test gcc 7.2 and binutils 2.29.
> Unfortunately, same issue: XZ-compressed data is corrupt - System Halted.

Has anyone been able to debug this further? It seems there are also issues
on iop32x/n2100 with GCC 7.2 and binutils 2.29.1 - early boot hangs silently
and I cannot get earlyprintk to work. Compiling with GCC 6.4.0 it's OK.

A.
