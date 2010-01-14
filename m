From: niam.niam@gmail.com (Ni@m)
Date: Fri, 15 Jan 2010 00:06:27 +0200
Subject: Problem with CPU Data cache
In-Reply-To: <OFD82C1D12.7D7C4E53-ON6525768E.00444887-6525768E.0046F2BF@lntemsys.com>
References: <OFD82C1D12.7D7C4E53-ON6525768E.00444887-6525768E.0046F2BF@lntemsys.com>
Message-ID: <a9e22dff1001141406q41fb3a67t27b636256d6e3f7f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

Apparently I'm also affected by almost similar problem with arm-946(no
MMU, MPU only) with 2.6.25 kernel. When data cache is enabled the
kernel is not able to decompress ramfs(crc error). Interesting that
this happens only if compressed ramfs is not 4-bytes aligned.

Disabling data cache is not preferable since this considerably
decreases boot time.

Best regards

-- Dima

On Wed, Dec 16, 2009 at 2:56 PM, <Virupax.SS@lntemsys.com> wrote:
>
> I am using at91sam9g20 with 2.6.27 linux kernel and having problem in booting the kernel on one of the board.
> I have analysed the arm register configuration and have seen by disabling the data cache in the kernel at the below locations, the kernel works fine on the bad board.
>
> 1) The "arch/arm/boot/compressed/head.S" which is used for decompressing the kernel and here i have changed the code manually to not to enable the data cache.
> writing #0x0009 instead of #0x000d to the c1 register of the cp15.
> 2) The "arch/arm/kernel/head.S" file and for this the CONFIG_CPU_DCACHE_DISABLE kernel config option is sufficient to disable the data cache enabling.
>
> If i dont do the first one , i get
> Uncompressing Linux.............................................................
> ................................................
> crc error
> -- System halted
>
> and if the first change is done and the seconds one is not done, then the kernel boots up but fails to mount the RFS. On doing both changes the kernel boots up fine with the RFS.
> I feel like data chache disabling is needed only at places where there is some king of data decompression.
>
> It will be helpful if you can give some input on this issue.
>
> Regards
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
