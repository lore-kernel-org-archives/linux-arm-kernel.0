From: joshc@ni.com (Josh Cartwright)
Date: Thu, 19 Mar 2015 08:37:05 -0500
Subject: [PATCH v2] ARM: zynq: use restart_handler mechanism for slcr reset
In-Reply-To: <BN1BFFO11FD008F29B247339CE49EAEA6AE2010@BN1BFFO11FD008.protection.gbl>
References: <1425049769-24929-1-git-send-email-joshc@ni.com>
 <BL2FFO11OLC004560F6047881E93573D75E2010@BL2FFO11OLC004.protection.gbl>
 <20150319124414.GG24619@jcartwri.amer.corp.natinst.com>
 <BN1BFFO11FD008F29B247339CE49EAEA6AE2010@BN1BFFO11FD008.protection.gbl>
Message-ID: <20150319133705.GB23626@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 02:19:01PM +0100, Michal Simek wrote:
> On 03/19/2015 01:44 PM, Josh Cartwright wrote:
> > On Thu, Mar 19, 2015 at 11:44:23AM +0100, Michal Simek wrote:
> >> On 02/27/2015 04:09 PM, Josh Cartwright wrote:
> > [..]
> >>> +++ b/arch/arm/mach-zynq/slcr.c
> >>> @@ -15,6 +15,7 @@
> >>>   */
> >>>  
> >>>  #include <linux/io.h>
> >>> +#include <linux/reboot.h>
> >>>  #include <linux/mfd/syscon.h>
> >>>  #include <linux/of_address.h>
> >>>  #include <linux/regmap.h>
> >>> @@ -91,10 +92,9 @@ u32 zynq_slcr_get_device_id(void)
> >>>  	return val;
> >>>  }
> >>>  
> >>> -/**
> >>> - * zynq_slcr_system_reset - Reset the entire system.
> >>> - */
> >>> -void zynq_slcr_system_reset(void)
> >>> +static
> >>> +int zynq_slcr_system_restart(struct notifier_block *nb,
> >>> +			     unsigned long action, void *data)
> >>>  {
> >>
> >> First of all sorry for delay.
> > 
> > No problem.  I suspect ZynqMP is keeping you busy.
> 
> yes.
> 
> > 
> >> Any reason to remove kernel-doc format?
> > 
> > It didn't seem to provide anything meaningful, as it was just a
> > restatement of the function name, and since this function has become
> > static, it makes even less sense.
> 
> Even static function can do something interesting. The whole file
> is using kernel-doc that's why please also keep it here. If any function
> misses it then it is just a bug.

Okay, sure.  Sent out a v3 with the kerneldoc updated.

[..]
> > 
> > Has this FSBL bug been addressed?
> 
> To be honest the problem is that there could be users in the field which uses
> old fsbl and will start to deal with this problem.

Yeah,  I suppose we're destined to carry it for long time.

Thanks,
  Josh
