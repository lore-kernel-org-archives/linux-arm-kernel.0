From: alex@digriz.org.uk (Alexander Clouter)
Date: Wed, 15 Sep 2010 23:02:29 +0100
Subject: Maximum bootable kernel size in current ARM linux
References: <4C8DD588.7040009@endruntechnologies.com>
	<20100913100111.GA30787@n2100.arm.linux.org.uk>
	<4C8E7EFF.7020004@endruntechnologies.com>
	<alpine.LFD.2.00.1009141330230.19366@xanadu.home>
	<4C8FB71C.8010208@endruntechnologies.com>
	<alpine.LFD.2.00.1009141442330.19366@xanadu.home>
	<4C912CE4.3000306@endruntechnologies.com>
Message-ID: <lcs7m7-1hb.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bruce M. Penrod <bmpenrod@endruntechnologies.com> wrote:
> 
> U-Boot loads the zImage at 0x800000.  Yesterday I added features back 
> into the kernel and am up to 4600 * 1024 with no issues.  So definitely 
> not a hard limit at 4MB.  It takes quite a while to compile on the 
> OpenRD, so it may take a while for me to discover the magic combination 
> that doesn't work.  I removed a LOT of stuff, and I'd rather add it back 
> in gradually to get an idea whether it is a size issue or some bad other 
> thing with a combination of options.
> 
Cross compiling is dead easy, if you are a Debian user (*always* use 
'lenny' for emdebian, even if you are locally using 'squeeze' or 'sid'):
----
# cat <<EOF > /etc/apt/sources.list.d/emdebian.list
deb http://www.emdebian.org/debian/ lenny main
EOF

# aptitude update
# aptitude install gcc-4.3-arm-linux-gnueabi libc6-dev-armel-cross
----

Then when cross compiling you can use the shell alias:
----
alias amake="ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- make"
----

Then inside the Linux kernel directory just type 'amake menuconfig; 
amake'...much faster.

If you are not using Debian (why not? :) then you can use buildroot if 
your distro does not come with cross-compiling tools.  On my website I 
have a page describing the process for a MIPS platform, if you need any 
help do ask:

http://www.digriz.org.uk/wag54g

Cheers

-- 
Alexander Clouter
.sigmonster says: It's not the inital skirt length, it's the upcreep.
