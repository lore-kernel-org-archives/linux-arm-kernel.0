From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sun, 16 Feb 2014 12:28:02 -0300
Subject: [REGRESSION] 3.14-rc2 boot failure on Kirkwood (qnap ts-119p+)
In-Reply-To: <21248.54474.414445.790516@gargle.gargle.HOWL>
References: <21248.39509.418884.931848@gargle.gargle.HOWL>
 <20140216143735.GA8680@localhost>
 <21248.54474.414445.790516@gargle.gargle.HOWL>
Message-ID: <20140216152802.GA3637@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 16, 2014 at 04:10:02PM +0100, Mikael Pettersson wrote:
> Ezequiel Garcia writes:
>  > Hi Mikael,
>  > 
>  > On Sun, Feb 16, 2014 at 12:00:37PM +0100, Mikael Pettersson wrote:
>  > > My Kirkwood box worked fine with the 3.13 kernel, but with 3.14-rc2
>  > > boot always fails due to a kernel NULL dereference in __clk_put.
>  > > 
>  > > This is a non-DT kernel, with:
>  > > 
>  > > CONFIG_ARCH_KIRKWOOD=y
>  > > CONFIG_KIRKWOOD_LEGACY=y
>  > > CONFIG_MACH_TS219=y
>  > > # CONFIG_ARCH_KIRKWOOD_DT is not set
>  > > 
>  > 
>  > Thanks for the report. I thought this issue was already fixed, but I
>  > cannot find it on either the mailing lists or linux-next.
>  > 
>  > So, in case it hasn't been fixed here's an untested fix for you to test.
>  > Please try this patch and let us know.
>  > 
>  > Your SATA won't work but if the patch is OK the kernel wont't blow away.
> 
> Thanks, this fixes the oops but does leave sata_mv non-functional,
> which is still a major regression from 3.13.
> 

Please, try linux-next to get the most recent fixes and make sure you have
CONFIG_PHY_MVEBU_SATA enabled.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
