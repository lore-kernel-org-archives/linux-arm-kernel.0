From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Sep 2014 11:16:32 +0100
Subject: [RFC] arm:extend the reserved mrmory for initrd to be page aligned
In-Reply-To: <35FD53F367049845BC99AC72306C23D103D6DB491605@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103D6DB4915FC@CNBJMBX05.corpusers.net>
 <20140915084616.GX12361@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103D6DB491604@CNBJMBX05.corpusers.net>
 <20140915093014.GZ12361@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103D6DB491605@CNBJMBX05.corpusers.net>
Message-ID: <20140915101632.GA12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 05:59:27PM +0800, Wang, Yalin wrote:
> Hi
> 
> Add more log:
> <4>[    0.000000] INITRD unalign phys address:0x02000000+0x0022fb0e
> <4>[    0.000000] INITRD aligned phys address:0x02000000+0x00230000
> <4>[    0.574868] free_initrd: free initrd 0xc2000000+0xc222fb0e
> <4>[    0.579398] free_initrd_mem: free pfn:8192---8752
> 
> The inird used memory is still the same as the one passed by bootloads,
> I don't change it. It should be safe.

This tells me nothing about whether the initrd is actually /used/.  What
it tells me is that it's being freed.  The function of an initrd is not
to be a chunk of memory which gets freed later on in the boot process.
It is there to provide an "initial ramdisk" (whether it be a filesystem
image, or a CPIO compressed archive) for userspace to run.

So, have you checked that initrd is still functional after this patch?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
