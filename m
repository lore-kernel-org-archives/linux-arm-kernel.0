From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 9 Jul 2015 20:14:38 -0700
Subject: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
In-Reply-To: <559F2719.3060708@atmel.com>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
 <20150709173747.GA32448@roeck-us.net> <559F2719.3060708@atmel.com>
Message-ID: <20150710031438.GA27089@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 09:59:53AM +0800, Josh Wu wrote:
> Hi, Guenter
> 
> On 7/10/2015 1:37 AM, Guenter Roeck wrote:
> >On Thu, Jul 09, 2015 at 06:15:46PM +0800, Josh Wu wrote:
> >>As since sama5d3, to reset the chip, we don't need to shutdown the ddr
> >>controller.
> >>
> >>So add a new compatible string and new restart function for sama5d3 and
> >>later chips. As we don't use sama5d3 ddr controller, so remove it as
> >>well.
> >>
> >That sounds like it should be two separate patches, or am I missing something ?
> 
> I think using one patch makes more sense. Maybe the commit log is not clear
> enough. How about put it this way:
> 
> This patch introduces a new compatible string: "atmel,sama5d3-rstc" for the
> reset driver of sama5d3 and later chips.
> As in sama5d3 or later chips, we don't have to shutdown the DDR controller
> before reset. Shutdown the DDR controller before reset is a workaround to
> avoid DDR signal driving the bus, but since sama5d3 and later chips there is
> no such a conflict.
> That means:
>   1. the sama5d3 reset function only need to write the rstc register and
> return.
>   2. for sama5d3, we can remove the code related with DDR controller as we
> don't use it at all.
> 
Sorry, I don't get it. Doesn't that mean there are two distinct logical
changes, which would ask for two separate patches ?

Guenter
