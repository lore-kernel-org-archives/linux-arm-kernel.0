From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Feb 2016 17:31:37 +0000
Subject: [PATCH 1/2] ARM: make virt_to_idmap() return unsigned long
In-Reply-To: <56AF917F.9030505@oracle.com>
References: <E1aO8F2-00074N-E8@rmk-PC.arm.linux.org.uk>
 <56A84748.3040108@oracle.com>
 <20160201152015.GU10826@n2100.arm.linux.org.uk>
 <56AF8F54.7030805@ti.com> <56AF917F.9030505@oracle.com>
Message-ID: <20160201173137.GV10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 09:10:23AM -0800, santosh shilimkar wrote:
> Based on the log, I think the patch seems to work fine since the boot
> reached upto rootfs. The crash seems to be coming from mostky NetCP
> related compents.

I read the boot log slightly differently - I'm assuming that the
boot log is from the kernel which _will_ be kexec'd from, so we
don't yet know whether the patches work or not.

I looked at the oops, and it's in tasklet_action, but for some
reason the unwinder is unable to unwind and provide a backtrace,
so it's not very debuggable.

However, this is a useful backtrace for me in a different way:
to provide to people who want to deprecate the frame-pointer
based backtracing to prove why the unwinder based solution still
isn't up to the job.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
