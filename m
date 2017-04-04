From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 03 Apr 2017 23:28:22 -0700
Subject: [PATCH v2] arm64: print a fault message when attempting to write
 RO memory
In-Reply-To: <20170323142239.GL29752@arm.com>
References: <20170217011959.26754-1-stephen.boyd@linaro.org>
 <58A6D7D7.1030704@arm.com>
 <148734678579.30076.8827985106565313944@sboyd-linaro>
 <58AACE92.4040608@arm.com>
 <148798674891.16996.12830433270375215535@sboyd-linaro>
 <20170323142239.GL29752@arm.com>
Message-ID: <149128730233.11428.502726622958797119@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Will Deacon (2017-03-23 07:22:39)
> On Fri, Feb 24, 2017 at 05:39:08PM -0800, Stephen Boyd wrote:
> > Quoting James Morse (2017-02-20 03:10:10)
> > > 
> > > You're right the user-address side of things will get caught in do_page_fault().
> > > I was trying to badly-explain 'is_permission_fault(esr)' isn't as general
> > > purpose as its name and prototype suggest, it only gives the results that the
> > > PAN checks expect when called with a user address.
> > 
> > Ok. I'd rather not change the function in this patch because I'm only
> > moving the code around to use it higher up in the file. But if you
> > prefer I can combine the code movement with the addition of a new 'addr'
> > argument to this function and rework things based on that.
> 
> Are you planning to send a v3 of this?
> 

Sorry for the late reply. I was hoping that James would indicate
preference one way or the other. I suppose no reply means "yes" here, so
I'll go ahead and fold everything together into one patch and resend.
