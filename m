From: stefan@agner.ch (Stefan Agner)
Date: Thu, 09 Jul 2015 17:21:34 +0200
Subject: [PATCH v6 4/6] ARM: vf610: enable NAND Flash Controller
In-Reply-To: <20150709015551.GJ28488@tiger>
References: <1434668319-6651-1-git-send-email-stefan@agner.ch>
 <1434668319-6651-5-git-send-email-stefan@agner.ch>
 <20150708093801.GG28488@tiger>
 <BLU436-SMTP255283C042EDEF59D9BA0CFB8910@phx.gbl>
 <20150709015551.GJ28488@tiger>
Message-ID: <9fa2a68a7c6acf55b1bfe604fbfac009@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-07-09 03:55, Shawn Guo wrote:
> On Wed, Jul 08, 2015 at 10:32:54AM -0400, Bill Pringlemeir wrote:
>>
>> On  8 Jul 2015, shawnguo at kernel.org wrote:
>> > On Fri, Jun 19, 2015 at 12:58:37AM +0200, Stefan Agner wrote:
>> >> Enable the NAND Flash Controller driver which is part of the Vybrid
>> >> SoC by default.
>> >>
>> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> >> ---
>> >> arch/arm/mach-imx/Kconfig | 1 +
>> >> 1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
>> >> index 3a3d3e9..9358135 100644
>> >> --- a/arch/arm/mach-imx/Kconfig
>> >> +++ b/arch/arm/mach-imx/Kconfig
>> >>>> -589,6 +589,7 @@ config SOC_VF610
>> >> 	select PINCTRL_VF610
>> >> 	select PL310_ERRATA_769419 if CACHE_L2X0
>> >> 	select SMP_ON_UP if SMP
>> >> +	select HAVE_NAND_VF610_NFC
>>
>> > I'm not sure about the benefit of having this option, except we have
>> > to have this additional architecture patch.
>>
>> For other SOC, like the PowerPC or ColdFire CPUs with this controller,
>> it was a way to mark the controller as populated.  Otherwise, the
>> Kconfig entry to select the controller will pop up for everybody.
> 
> IMHO, having the option pop up for everybody isn't really a problem.  On
> the other hand, we can even compile test the driver on any architecture
> without the COMPILE_TEST dependency.

I think the distro people don't like that too much. Afaik they enable
all drivers as modules, and hence the NAND driver would end up as kernel
module in x86 distros... 

Reminds me that I wanted to send a patch to add the dependencies of
STE_MODEM_RPROC, I recently stumbled upon the remoteproc/ste_modem_rproc
kernel modules on my distro, which both are actually not really useful
on x86 :-)


> But if MTD maintainer has a different opinion, we can still have a
> 'depends on SOC_VF610' to save this patch.

I think this is the better solution, and Sebastian suggested that too. I
will implement that in the next patch revision...

--
Stefan
