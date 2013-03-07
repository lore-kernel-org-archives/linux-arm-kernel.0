From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 7 Mar 2013 17:12:06 +0800 (HKT)
Subject: [PATCH 00/16] big.LITTLE low-level CPU and cluster power
 management
In-Reply-To: <20130307082721.GB28982@xo-6d-61-c0.localdomain>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <20130307082721.GB28982@xo-6d-61-c0.localdomain>
Message-ID: <alpine.LFD.2.03.1303071701330.28820@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Mar 2013, Pavel Machek wrote:

> Hi!
> 
> > Review comments are welcome!
> > 
> > [*] General design information on the b.L switcher can be found here:
> >     http://lwn.net/Articles/481055/
> >     However the code is only accessible to Linaro members for the
> >     time being.
> 
> Assuming the lwn article is accurate:
> 
> Hmm. So we have hw capable of running 8 cores, and then we introduce strange
> switching code, because "scheduler is not ready". Sounds like a bad idea.
> 
> I'd say:
> 
> * expose all 8 cores.

You may do that now.  However the resulting power efficiency is far from 
optimal.

> * as long as scheduler is not ready, you can offline "the other" set of cores...
> 	/sys/.../cpu/..../online

You may do that now also.  But system performance is far from optimal.

> That way, I suspect scheduler will be fixed rather quickly.

If we could fix the scheduler quickly, we would have done that instead.  
But if you have a good idea for fixing it quickly, then please join the 
people who have been working on that problem for over a year already.


Niicolas
