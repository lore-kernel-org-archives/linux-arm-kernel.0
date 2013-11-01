From: gerg@uclinux.org (Greg Ungerer)
Date: Fri, 01 Nov 2013 11:59:10 +1000
Subject: [PATCHv2 3/7] ARM: imx: add support code for IMX50 based machines
In-Reply-To: <20131031061041.GC23549@S2101-09.ap.freescale.net>
References: <1383023757-30711-1-git-send-email-gerg@uclinux.org>
 <1383023757-30711-4-git-send-email-gerg@uclinux.org>
 <20131031061041.GC23549@S2101-09.ap.freescale.net>
Message-ID: <52730AEE.1000408@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 31/10/13 16:10, Shawn Guo wrote:
> On Tue, Oct 29, 2013 at 03:15:53PM +1000, gerg at uclinux.org wrote:
>> +DT_MACHINE_START(IMX50_DT, "Freescale i.MX50 (Device Tree Support)")
>> +	.map_io		= mx53_map_io,
>> +	.init_early	= imx53_init_early,
>> +	.init_irq	= mx53_init_irq,
>> +	.handle_irq	= imx53_handle_irq,
>> +	.init_machine	= imx50_dt_init,
>> +	.init_late	= imx53_init_late,
>> +	.dt_compat	= imx50_dt_board_compat,
>> +	.restart	= mxc_restart,
>> +MACHINE_END
> 
> The imx53 is a platform that was converted from non-DT to DT.  Some of
> these imx53 hooks may not even necessary for imx53 now, since imx53
> supports DT boot only today.  So I do not prefer to reuse these imx53
> hooks on the brand new imx50 DT machine.  I would suggest to maintain a
> mach-imx50.c and machine descriptor for imx50 with only the necessary
> hooks implemented as local functions inside mach-imx50.c.  After imx53
> machine descriptor and hooks gets cleaned up, we can look at how we can
> consolidate these descriptors if they are pretty much in common.

With the current support I could drop .init_early and .init_late
I believe. All the other mx53 functions are needed to successfully
boot.

imx53_handle_irq is easy to fix, it is just defined to be
tzic_handle_irq anyway.

mx53_map_io and mx53_init_irq are coded in mm-imx5.c. They look strait
forward. Do you want me to create imx50 specific versions in there?

Regards
Greg
