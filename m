From: bhaskarbudiredla@gmail.com (Bhaskara rao Budiredla)
Date: Wed, 13 May 2015 00:03:09 +0530
Subject: Physical memory start address for ARM cores
In-Reply-To: <20150511214044.GJ2067@n2100.arm.linux.org.uk>
References: <CAJWVF-whTD0Nm-cup-qOt-M-PYn-6GojSiE9pS2Db0R35D5aUQ@mail.gmail.com>
 <20150511214044.GJ2067@n2100.arm.linux.org.uk>
Message-ID: <CAJWVF-yORg=t=ccrCppRYNOc5-Ar4P1rpmYUVDqjXdBg8BWsow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sure, we can live with that. Thank you for the quick help.

Thanks,
Bhaskara

On Tue, May 12, 2015 at 3:10 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, May 11, 2015 at 08:47:21PM +0530, Bhaskara rao Budiredla wrote:
>> Could you please confirm if ARM architecture mandates the physical
>> memory start address to align with a MegaBye boundary (something like
>> 0xXXX00000)? I am seeing Linux Kernel crash if I relax that
>> restriction.
>
> The ARM architecture doesn't, but we (the kernel) does restrict it for
> the sake of cross-machine portability.  See this comment in
> arch/arm/boot/compressed.S:
>
>                 /*
>                  * Find the start of physical memory.  As we are executing
>                  * without the MMU on, we are in the physical address space.
>                  * We just need to get rid of any offset by aligning the
>                  * address.
>                  *
>                  * This alignment is a balance between the requirements of
>                  * different platforms - we have chosen 128MB to allow
>                  * platforms which align the start of their physical memory
>                  * to 128MB to use this feature, while allowing the zImage
>                  * to be placed within the first 128MB of memory on other
>                  * platforms.  Increasing the alignment means we place
>                  * stricter alignment requirements on the start of physical
>                  * memory, but relaxing it means that we break people who
>                  * are already placing their zImage in (eg) the top 64MB
>                  * of this range.
>                  */
>
> We will never change this requirement, as changing it breaks existing
> platforms, and that's not allowed.
>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.



-- 
.
