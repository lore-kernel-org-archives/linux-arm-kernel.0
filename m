From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 13 Oct 2014 20:11:22 -0300
Subject: Where is DRAM initialisation done?
In-Reply-To: <CAOMZO5Dj3N=KGKyMtg+FdAx55uFoDvuTA2GmjhwJJU-B7P0DmA@mail.gmail.com>
References: <543C560D.5070305@vrt.com.au>
 <CAOMZO5Dj3N=KGKyMtg+FdAx55uFoDvuTA2GmjhwJJU-B7P0DmA@mail.gmail.com>
Message-ID: <CAOMZO5DfsimNGHS5KB133GHQuyD2hQx6ChNcVqm_ZraLY9VhMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 13, 2014 at 8:02 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Oct 13, 2014 at 7:45 PM, Stuart Longland <stuartl@vrt.com.au> wrote:
>
>> In the old kernel[3] (based on Freescale's fork of 2.6.35), there was
>> some DRAM init code stuffed in arch/arm/mach-mx28, which Technologic
>> Systems patched to make it work.
>>
>> Does anyone happen to know where in the mainline kernel this is done, if
>> at all?
>
> The DDR is initialized only by the bootloader.
>
> You can check arch/arm/cpu/arm926ejs/mxs/spl_mem_init.c in U-boot.

Also, maybe it can help if you have access to the old source code
where the DDR is initialized.

The 'old' way of doing the DDR init is via a separate package called 'bootlets'.

So if you have access to the bootlets code, it would be easy to port
the DDR init into U-boot.
