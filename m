From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Thu, 1 Jul 2010 09:42:55 +0300
Subject: [PATCH 0/4] crash utility: add ARM crashdump support
In-Reply-To: <482970280.508981277903458507.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
References: <1093965077.507331277902686384.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<482970280.508981277903458507.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
Message-ID: <20100701064255.GA25358@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 30, 2010 at 03:10:58PM +0200, ext Dave Anderson wrote:
> 
> Actually I have a problem with this -- although I think it's a good one for you...
> 
> As I understand it, this patch-set will run on an ARM host against either
> an ARM kdump-ELF or makedumpfile-generated dumpfile, and presumably on a
> live ARM system.

Right. Except that current patch set only supports makedumpfile generated
dumpfile.

> As it turns out, over the last couple of weeks, I've been going back-and-forth
> with another ARM-support patch-set created by Jan Karlsson and Thomas Fange of 
> Sony Ericcson.  However, their patch set is designed to be built on and run
> on a 32-bit x86 host, although I think that with a very minor tweak, it could
> also could be built and run on an ARM host.  For that reason, it doesn't support
> running on a live ARM system, but rather only for ARM dumpfiles running
> on an x86 host (or x86_64 given its capability of running 32-bit binaries).

Good to know. I didn't notice that someone else was doing the similar thing.

As there is no cross-architecture support in current crash, I decided to take
the easiest route and make it run natively on ARM. It works on i386 as well but
only because of the same endianess and word size. So I'm currently running this
on the target device or under ARM linux-user QEMU.

> In any case, I'm more than happy to fold in ARM support, but I don't know what
> to do in this case.
> 
> I wonder if it would it be possible for you, Jan and Thomas to somehow collaborate
> on this effort?  It seems that both sides would benefit from the work of the other
> side.  I've added them to the cc list.

Sure. Can those patches be found in some public ML? I quickly searched but
couldn't find anything.

Regards,
MW
