From: jcm@redhat.com (Jon Masters)
Date: Sun, 13 Dec 2015 16:36:30 -0500 (EST)
Subject: [Linaro-acpi] Touching the initrd before paging_init
In-Reply-To: <20151213165942.GN25034@bivouac.eciton.net>
References: <566D3090.9090509@redhat.com>
 <20151213165942.GN25034@bivouac.eciton.net>
Message-ID: <23071B8C-D1F9-47A6-9DB4-B26842150B76@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just thinking from a parity point of view - if you can do it on x86, it should be doable on ARM. But that GRUB module approach I quite like! Let's get it documented prominently in the kernel doc as the alternative to updating an initrd then :)

(In our case we would only turn this on in -debug RHEL kernels so as to keep it very clear this is never for production systems, can't trust folks not to hack things if you give them half a chance)

Jon.

-- 
Computer Architect | Sent from my 64-bit #ARM Powered phone

> On Dec 13, 2015, at 11:59, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> 
>> On Sun, Dec 13, 2015 at 03:47:12AM -0500, Jon Masters wrote:
>> I mentioned before that we'll want to see ACPI_INITRD_TABLE_OVERRIDE
>> support on arm64 in due course for use during bringup of new systems. It
>> is commonly used on x86 to provide handy updated ACPI tables via a
>> prepended initrd cpio that is attached to the regular initrd image,
>> which is infinitely better than respinning firmware each time you want
>> to provide updated tables (yes yes, we all know the "devicetree"
>> directive in GRUB does this with DT and that's great and wonderful). I
>> know that someone is working on it, but I had a need for an interim
>> solution over the weekend for some hardware I am bringing up here.
> 
> Why would we do this through an initrd?
> That sounds an awful lot like the per-kernel-image dtbs that are the whole
> thing we're trying to avoid.
> 
> Implementing this as a grub command (or kernel command line) for debug
> purposes would be trivial - and I'm pretty sure Graeme/Al already did
> this in the past.
> 
> /
>    Leif
