From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Mon, 15 Sep 2014 17:59:27 +0800
Subject: [RFC] arm:extend the reserved mrmory for initrd to be page aligned
In-Reply-To: <20140915093014.GZ12361@n2100.arm.linux.org.uk>
References: <35FD53F367049845BC99AC72306C23D103D6DB4915FC@CNBJMBX05.corpusers.net>
 <20140915084616.GX12361@n2100.arm.linux.org.uk>
 <35FD53F367049845BC99AC72306C23D103D6DB491604@CNBJMBX05.corpusers.net>
 <20140915093014.GZ12361@n2100.arm.linux.org.uk>
Message-ID: <35FD53F367049845BC99AC72306C23D103D6DB491605@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Add more log:
<4>[    0.000000] INITRD unalign phys address:0x02000000+0x0022fb0e
<4>[    0.000000] INITRD aligned phys address:0x02000000+0x00230000
<4>[    0.574868] free_initrd: free initrd 0xc2000000+0xc222fb0e
<4>[    0.579398] free_initrd_mem: free pfn:8192---8752

The inird used memory is still the same as the one passed by bootloads,
I don't change it. It should be safe.


-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Monday, September 15, 2014 5:30 PM
To: Wang, Yalin
Cc: 'Will Deacon'; 'linux-kernel at vger.kernel.org'; 'linux-arm-kernel at lists.infradead.org'; 'linux-mm at kvack.org'; linux-arm-msm at vger.kernel.org
Subject: Re: [RFC] arm:extend the reserved mrmory for initrd to be page aligned

On Mon, Sep 15, 2014 at 05:07:53PM +0800, Wang, Yalin wrote:
> Hi
> 
> I tested it on my phone,
> >From log:
> <4>[    0.000000] INITRD unalign phys address:0x02000000+0x0022fb0e
> <4>[    0.000000] INITRD aligned phys address:0x02000000+0x00230000
> 
> <4>[    0.579474] free_initrd_mem: free pfn:8192---8752
> 
> The tail address is not aligned for most initrd image, This page will 
> not be freed and lost .

Right, so from this I can assume that you only tested it by seeing what the addresses were, and the values used in free_initrd_mem().

What you haven't tested is whether the initrd actually gets used with your changes, which is more what I was interested in given what I found when reading your patch.

--
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up according to speedtest.net.
