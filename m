From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Jul 2016 14:42:10 +0100
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <20160715132610.GD23514@redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <4321972.HZgDox36RC@wuerfel> <3520758.yAgMzqF1PF@hactar>
 <5547846.5l81k4b13o@wuerfel> <20160715132610.GD23514@redhat.com>
Message-ID: <20160715134209.GF1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 09:26:10AM -0400, Vivek Goyal wrote:
> On Fri, Jul 15, 2016 at 09:31:02AM +0200, Arnd Bergmann wrote:
> > I think that helps, as it makes the problem space correspond to that
> > of modifying the command line, but I can still come up with countless
> > attacks based on modifications of the /chosen node and/or the command
> > line, in fact it's probably easier than any other node.
> 
> I don't know anything about DTB. So here comes a very basic question. Does
> DTB allow passing an executable blob to kernel or pass the location of
> some unsigned executable code at kernel level.

DT on ARM is a description of the hardware - it can be thought of as a
set of nodes with properties attached.  The properties can describe
anything (we have documentation in Documentation/devicetree/bindings
which describes what we expect the properties to contain.)

On other architectures, DT can also contain open-firmware "functions"
but I don't think there's much support in the kernel for that - maybe
the PPC folk can reply on that point.

It is possible that someone may, at some point, decide to create a
property that points to some executable blob, but I can't think of a
reason why we should ever allow such a monstrosity in mainline kernels.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
