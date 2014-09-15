From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Mon, 15 Sep 2014 18:22:12 +0800
Subject: [RFC] arm:extend the reserved mrmory for initrd to be page aligned
In-Reply-To: <20140915101632.GA12361@n2100.arm.linux.org.uk>
References: <35FD53F367049845BC99AC72306C23D103D6DB4915FC@CNBJMBX05.corpusers.net>
 <20140915084616.GX12361@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103D6DB491604@CNBJMBX05.corpusers.net>
 <20140915093014.GZ12361@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103D6DB491605@CNBJMBX05.corpusers.net>
 <20140915101632.GA12361@n2100.arm.linux.org.uk>
Message-ID: <35FD53F367049845BC99AC72306C23D103D6DB491606@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Oh, I see your meaning,
Yeah , my initrd is a cpio image,
And it can still work after apply this patch.


-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Monday, September 15, 2014 6:17 PM
To: Wang, Yalin
Cc: 'Will Deacon'; 'linux-kernel at vger.kernel.org'; 'linux-arm-kernel at lists.infradead.org'; 'linux-mm at kvack.org'; linux-arm-msm at vger.kernel.org
Subject: Re: [RFC] arm:extend the reserved mrmory for initrd to be page aligned

On Mon, Sep 15, 2014 at 05:59:27PM +0800, Wang, Yalin wrote:
> Hi
> 
> Add more log:
> <4>[    0.000000] INITRD unalign phys address:0x02000000+0x0022fb0e
> <4>[    0.000000] INITRD aligned phys address:0x02000000+0x00230000
> <4>[    0.574868] free_initrd: free initrd 0xc2000000+0xc222fb0e
> <4>[    0.579398] free_initrd_mem: free pfn:8192---8752
> 
> The inird used memory is still the same as the one passed by 
> bootloads, I don't change it. It should be safe.

This tells me nothing about whether the initrd is actually /used/.  What it tells me is that it's being freed.  The function of an initrd is not to be a chunk of memory which gets freed later on in the boot process.
It is there to provide an "initial ramdisk" (whether it be a filesystem image, or a CPIO compressed archive) for userspace to run.

So, have you checked that initrd is still functional after this patch?

--
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up according to speedtest.net.
