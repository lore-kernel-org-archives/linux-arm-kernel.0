From: linux@roeck-us.net (Guenter)
Date: Fri, 10 Jul 2015 10:01:19 -0700
Subject: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
In-Reply-To: <20150710055658.GZ3127@piout.net>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
 <20150709173747.GA32448@roeck-us.net> <559F2719.3060708@atmel.com>
 <20150710031438.GA27089@roeck-us.net>
 <20150710055658.GZ3127@piout.net>
Message-ID: <20150710170119.GA6585@groeck-UX31A>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 07:56:58AM +0200, Alexandre Belloni wrote:
> Hi Guenter,
> 
> On 09/07/2015 at 20:14:38 -0700, Guenter Roeck wrote :
> > > This patch introduces a new compatible string: "atmel,sama5d3-rstc" for the
> > > reset driver of sama5d3 and later chips.
> > > As in sama5d3 or later chips, we don't have to shutdown the DDR controller
> > > before reset. Shutdown the DDR controller before reset is a workaround to
> > > avoid DDR signal driving the bus, but since sama5d3 and later chips there is
> > > no such a conflict.
> > > That means:
> > >   1. the sama5d3 reset function only need to write the rstc register and
> > > return.
> > >   2. for sama5d3, we can remove the code related with DDR controller as we
> > > don't use it at all.
> > > 
> > Sorry, I don't get it. Doesn't that mean there are two distinct logical
> > changes, which would ask for two separate patches ?
> 
> I would agree with Josh and I think that only one patch is needed. There
> is only one change, the removal of the workaround for sama5d3 and later.
> 
> As the workaround is using a table of compatibles to remap the ram
> controller and the one for sama5d3 is not used because it is not needed,
> I think it makes sense to remove it in that same patch. The logical
> change here is the removal of the workaround.
> 
Ok, makes sense.

Thanks,
Guenter
