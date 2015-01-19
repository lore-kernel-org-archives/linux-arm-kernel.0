From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 19 Jan 2015 14:43:53 +0100
Subject: [PATCHv5 0/6] USB: host: Atmel OHCI and EHCI drivers improvements
In-Reply-To: <54BD07DC.6020802@atmel.com>
References: <20150118211728.GA21128@gradator.net>
 <1421619935-5022-1-git-send-email-sylvain.rochet@finsecur.com>
 <54BD07DC.6020802@atmel.com>
Message-ID: <20150119134353.GA3868@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nicolas,


On Mon, Jan 19, 2015 at 02:34:20PM +0100, Nicolas Ferre wrote:
> Le 18/01/2015 23:25, Sylvain Rochet a ?crit :
> > USB: host: Atmel OHCI and EHCI drivers improvements
> > 
> > Suspend/resume support for EHCI.
> > struct dev_pm_ops for OHCI.
> > Removed global variables from both.
> > Fixed OHCI wake up support for STANDBY(wake-up enabled) and MEM(wake-up 
> > disabled) sleep targets.
> 
> I'm okay with the whole series:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Oops, you missed that, but there is a v6 I sent this morning, which 
fixes a small mistake I made in v5.


> Alan, It seems that Boris and Alexandre also add their tag to the 
> series already. Do you want us to collect them in a new series sent to 
> you?
> 
> Sylvain,
> Thanks a lot for this nice series built at a high pace ;-)

Yeah, I have the feeling I messed up a "little" :-)

Anyway, v6 is fine, I hope.


> Even if I'm not sure to keep the separation between "slow clock" PM and
> "normal" PM on AT91 but more likely to use the "slow clock" for all the
> PM modes, let's go forward with this step for now. I mean, we will
> certainly rework this at91_suspend_entering_slow_clock() aspect in the
> future.

I agree, I discussed privately with Boris about that, this require a 
larger rework, lets only fix the OHCI wakeup bug for now.


Sylvain
