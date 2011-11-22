From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 22 Nov 2011 18:26:16 +0900
Subject: [PATCH] ARM: Kota2 mach-type update fix
In-Reply-To: <20111122060857.23951.50598.sendpatchset@w520>
References: <20111122060857.23951.50598.sendpatchset@w520>
Message-ID: <20111122092615.GA26411@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 03:08:57PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch adds kota2 to the in-kernel ARM mach-type file.
> 
> Basic board support is included in 3.2-rc and the mach-type
> has been registered in the ARM machine repository as
> 
> 3616 Renesas SH-Mobile kota2.x Board kota2 Yusuke Goda mainlined
> 
> The file arch/arm/tools/mach-types is however missing Kota2
> which makes build of sh73a0 based boards fail with:
> 
> arch/arm/mach-shmobile/platsmp.c: In function 'shmobile_smp_get_core_count':
> arch/arm/mach-shmobile/platsmp.c:28:2: error: implicit declaration of function 'machine_is_kota2'
> make[1]: *** [arch/arm/mach-shmobile/platsmp.o] Error 1
> 
> arch/arm/mach-shmobile/board-kota2.c:448:136: error: 'MACH_TYPE_KOTA2' undeclared here (not in a function)
> make[1]: *** [arch/arm/mach-shmobile/board-kota2.o] Error 1
> make: *** [arch/arm/mach-shmobile] Error 2
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  I propose that Paul Mundt merges this patch together with other
>  SH-Mobile ARM related fixes.
> 
Err, no. I'm not patching machine-generated files which precisely say not
to patch them at the top of the file. If there is a missing definition
for an upstream board then the file needs to be regenerated with the new
definitions, plain and simple.
