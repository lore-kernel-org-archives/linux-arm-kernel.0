From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Oct 2018 11:24:13 +0100
Subject: [PATCH] traps:Recover undefined user instruction on ARM
In-Reply-To: <20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba~anUhv_CDP0965009650epcas5p34@epcas5p3.samsung.com>
References: <CGME20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba@epcas5p3.samsung.com>
 <20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba~anUhv_CDP0965009650epcas5p34@epcas5p3.samsung.com>
Message-ID: <20181005102412.GI30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2018 at 10:15:57AM +0530, Manjeet Pawar wrote:
> From: Rohit Thapliyal <r.thapliyal@samsung.com> 
> 
> During user undefined instruction exception, the arm exception
> handler currently results in application crash through SIGILL.
> The bad instruction can be due to ddr/hardware issue.
> For such cases, exception trap handler could try to recover the corrupted
> text by clearing pagetable entry of undefined instruction pc and trying to fetch
> the instruction opcode by generating major page fault.
> Resulting in loading the page with correct instruction from mapped file.
> If there is no error in root filesystem i.e. the opcode is intact
> in file, then filemap fault shall be able to recover
> the instruction and continue execution normally instead of crashing.

For the reasons others have pointed out in previous replies, I will not
merge this patch or anything similar to this for mainline.  The only
sane solution to the above problem is to fix the hardware or the
hardware timings so that DDR access is reliable.

Sorry.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
