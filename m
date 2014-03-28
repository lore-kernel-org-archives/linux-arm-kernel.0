From: marc.ceeeee@gmail.com (Marc C)
Date: Fri, 28 Mar 2014 00:23:45 -0700
Subject: disabling MMU of ARMv7-A
In-Reply-To: <015e01cf4a55$7f43a950$7dcafbf0$@samsung.com>
References: <015e01cf4a55$7f43a950$7dcafbf0$@samsung.com>
Message-ID: <CAO1A-8DB_xAqAb2DOED3fmQ0GEOP4FFNyuZTVnjX+kiv4sRrtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanho,

> However, ARMv7-A/R doesn't have such register. They can only control whether
> use _HIGH_ vector or no

Not entirely accurate. ARMv7-A, and the Cortex-A9, specify the Vector
Base Address
Register, or VBAR [1].

-Marc

[1]http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0388f/CIHGDDEI.html

On Fri, Mar 28, 2014 at 12:15 AM, Chanho Park <chanho61.park@samsung.com> wrote:
> Hi all,
>
> I want to know is there anyone who tried disabling MMU of ARMv7-A likes
> cortex-a9.
> Yes. I know this is a silly question :)
> I turned off CONFIG_MMU option of my exynos4 board and specified
> CONFIG_DRAM_BASE/SIZE and REMAP_VECTORS_TO_RAM.
> The problem is occurred in here there is no way to specify the vector table
> address.
> As I know the cortex-M3/4 has VTOR(Vector table offset register) to specify
> the vector table address.
> However, ARMv7-A/R doesn't have such register. They can only control whether
> use _HIGH_ vector or not.
> In this situation, can I find a way to boot successfully with
> nommu+cortex-a9?
>
> Thanks.
>
> Best Regards,
> Chanho Park
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
