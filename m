From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 May 2013 00:40:24 +0100
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on
 Armada 370/XP
In-Reply-To: <20130524011724.515eac91@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130523142301.10dbeff9@skate>
 <20130523202643.GQ18614@n2100.arm.linux.org.uk>
 <201305232240.03959.arnd@arndb.de>
 <20130523230911.GR18614@n2100.arm.linux.org.uk>
 <20130524011724.515eac91@skate>
Message-ID: <20130523234024.GU18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 01:17:24AM +0200, Thomas Petazzoni wrote:
> Russell,
> 
> On Fri, 24 May 2013 00:09:11 +0100, Russell King - ARM Linux wrote:
> 
> > No, I'm not asking about the principle.  I'm asking _in this particular
> > problem case_ who provides the DT blob?
> > 
> > So the person to answer that question is Thomas or someone who is using
> > the boards concerned.
> 
> The DTB is built from arch/arm/boot/dts/, together with the kernel
> image itself. As far as I'm aware of, there is for the moment no plan
> to "burn" the DTB on the board and therefore make the Device Tree
> really separated from the kernel.

Right, so we're still in the position where we aren't dealing with
vendor provided DT blobs... this also means of course that the DT blob
isn't going to get updated by the boot loader depending on where it
decides to set the registers.

I suspect as far as the boot loaders on these boards go, the DT blob is
"just another file" to be loaded into memory by the boot loader, and it
is completely untouched by the boot loader.

Unfortunately, it also means that it's _completely_ our problem to select
the appropriate DT file for the boot loader behaviour, _or_ just not
bother with the problematical devices in DT and stick to "the old way"
of doing this if we can detect where they are.

For the latter, it really is not worth the effort of stuffing the DT file
full of definitions which are either (a) possibly wrong on the hardware
and (b) aren't being used because we're having to override them in the
kernel.

Another solution to this is to document the problem on a website, and
provide two DT blobs, and tell people to try one, if that fails to boot,
try the other, and only if that also fails to ask for help.  Yea, I know,
people don't bother reading websites though, it's loads easier to send
an email to a mailing list or someone else. :P
