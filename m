From: vgoyal@redhat.com (Vivek Goyal)
Date: Fri, 15 Jul 2016 09:03:42 -0400
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <20160715084925.GD1041@n2100.armlinux.org.uk>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <5352106.oQ0Ff9gWJA@wuerfel> <20160713094127.GC14522@leverpostej>
 <7352796.seiSnHrYPy@wuerfel>
 <20160715084925.GD1041@n2100.armlinux.org.uk>
Message-ID: <20160715130342.GB23514@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 09:49:25AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 13, 2016 at 03:13:42PM +0200, Arnd Bergmann wrote:
> > On Wednesday, July 13, 2016 10:41:28 AM CEST Mark Rutland wrote:
> > > The big question is whether this is a realistic case on a secure boot
> > > system.
> > 
> > What does x86 do here? I assume changes to the command line are also
> > limited.
> 
> They aren't.  You can specify /anything/ even with a fully-signed kernel
> and initrd, which was one of the things I pointed out in my previous
> set of responses.

Yes, kernel command line is not signed. For that matter even initird is
not signed. Just kernel is signed and its signatures are verified. Idea
is an unsigned code should not be able to execute in kernel space.

Vivek
