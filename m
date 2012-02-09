From: dave@jumpshift.com (David A. Long)
Date: Thu, 09 Feb 2012 15:05:26 -0500
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <1328664644.1678.15.camel@dave-Dell-System-XPS-L502X>
References: <1328578047.1724.17.camel@dave-Dell-System-XPS-L502X>
 <CACVXFVN0E_deS2d50mfufO5QZSwh=34BppCL++oxtc3nfN_ugA@mail.gmail.com>
 <1328664644.1678.15.camel@dave-Dell-System-XPS-L502X>
Message-ID: <1328817926.1726.15.camel@dave-Dell-System-XPS-L502X>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-02-07 at 20:30 -0500, David Long wrote:

> Investigating this again I can only see the clock jitter problem on 3.0.
> Even without the HWMOD_INIT_NO_IDLE flag on the 32k_counter entry I
> can't reproduce the problem on the later kernels, although I think our
> 3.3 may be showing a little more variability than the intervening
> versions.

Further testing reveals my observations above are specific to 4430.
4460 exhibits bad jitter on all versions I've tried.  Interestingly my
change to the 32k timer idle modes does not fix the problem on 4460.

I too found Santosh's change greatly improves the jitter problem, but it
still seems worse than 4430.

-dl
