From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Mon, 12 Oct 2015 15:56:22 +0200
Subject: [PATCH 6/6] watchdog: sama5d4: try to set timeout from device
 tree first
In-Reply-To: <B256D81BAE5131468A838E5D7A243641D632216B@penmbx01>
References: <1444340074-15437-1-git-send-email-sylvain.rochet@finsecur.com>
 <1444340074-15437-7-git-send-email-sylvain.rochet@finsecur.com>
 <20151012075001.GB3558@piout.net>
 <B256D81BAE5131468A838E5D7A243641D632216B@penmbx01>
Message-ID: <20151012135622.GA6845@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

On Mon, Oct 12, 2015 at 08:12:42AM +0000, Yang, Wenyou wrote:
> > -----Original Message-----
> > From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> > Sent: 2015?10?12? 15:50
> > To: Sylvain Rochet
> > Cc: Guenter Roeck; Boris BREZILLON; linux-kernel at vger.kernel.org; Ferre,
> > Nicolas; Desroches, Ludovic; linux-arm-kernel at lists.infradead.org; Yang,
> > Wenyou; Wim Van Sebroeck
> > Subject: Re: [PATCH 6/6] watchdog: sama5d4: try to set timeout from device tree
> > first
> > 
> > Hi Sylvain,
> > 
> > The rest of the series looks good to me, one comment below:
> > 
> > On 08/10/2015 at 23:34:34 +0200, Sylvain Rochet wrote :
> > > watchdog_init_timeout function doesn't try to get the "timeout-sec" DT
> > > property if timeout_parm is not zero. This change makes this DT
> > > property working for the sama5d4 watchdog driver.
> > >
> > 
> > While I'm not sure of the feasibility, I think that the module parameter should
> > override the DT property.
> 
> The patch should be right, the DT property overrides the module 
> parameter.
> 
> If the DT property is not a valid value, it uses the default value, 
> initialized with the module parameter at the beginning of probe.

Well, the principle of least surprise applied here means if you load the 
module with a timeout argument, you expect the timeout argument to be 
used and not the dt one. As such, it makes more sense to have the 
parameter value takes precedence over the dt value.

Sylvain
