From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 12 Oct 2015 11:09:30 +0200
Subject: [PATCH 6/6] watchdog: sama5d4: try to set timeout from device
 tree first
In-Reply-To: <20151012075001.GB3558@piout.net>
References: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
 <1444340074-15437-7-git-send-email-sylvain.rochet@finsecur.com>
 <20151012075001.GB3558@piout.net>
Message-ID: <20151012090930.GA747@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Mon, Oct 12, 2015 at 09:50:01AM +0200, Alexandre Belloni wrote:
> Hi Sylvain,
> 
> The rest of the series looks good to me, one comment below:
> 
> On 08/10/2015 at 23:34:34 +0200, Sylvain Rochet wrote :
> > watchdog_init_timeout function doesn't try to get the "timeout-sec" DT
> > property if timeout_parm is not zero. This change makes this DT property
> > working for the sama5d4 watchdog driver.
> 
> While I'm not sure of the feasibility, I think that the module parameter
> should override the DT property.

That's not that hard, we can remove the initialisation of wdt_timeout to 
WDT_DEFAULT_TIMEOUT and use the 0 magic value, which is not an 
acceptable timeout value, to tell whether the variable was set with a 
module parameter or not.

I followed what was done in the at91sam9_wdt driver but I agree the 
module parameter should override the DT property, if we all agree on 
that, I will also change this behavior in at91sam9_wdt in v2, at least 
for the sake of coherency between drivers.

Sylvain
