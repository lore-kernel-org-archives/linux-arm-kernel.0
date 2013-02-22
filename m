From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Fri, 22 Feb 2013 15:03:08 +0100
Subject: [PATCH 1/2] cpustat: use accessor functions for get/set/add
In-Reply-To: <1361541531.26780.57.camel@laptop>
References: <1361512604-2720-1-git-send-email-khilman@linaro.org>
 <1361512604-2720-2-git-send-email-khilman@linaro.org>
 <20130222133835.GF17948@somewhere.redhat.com>
 <1361541531.26780.57.camel@laptop>
Message-ID: <20130222140306.GA18149@somewhere.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 02:58:51PM +0100, Peter Zijlstra wrote:
> On Fri, 2013-02-22 at 14:38 +0100, Frederic Weisbecker wrote:
> > Looks good, just a minor neat:
> > 
> > On Thu, Feb 21, 2013 at 09:56:43PM -0800, Kevin Hilman wrote:
> > > diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> > > index 66b7078..df8ad75 100644
> > > --- a/include/linux/kernel_stat.h
> > > +++ b/include/linux/kernel_stat.h
> > > @@ -32,7 +32,7 @@ enum cpu_usage_stat {
> > >  };
> > >  
> > >  struct kernel_cpustat {
> > > -	u64 cpustat[NR_STATS];
> > > +	u64 _cpustat[NR_STATS];
> > 
> > Why do you need the underscore?
> 
> To make sure there's nobody still referencing the data directly instead
> of through the accessors.

Good point!
