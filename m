From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Feb 2014 20:13:02 +0000 (UTC)
Subject: [RFC PATCH] ARM: OMAP2+: clockdomain: Reintroduce SW_SLEEP
 Support (fwd)
In-Reply-To: <CANacCWxZ8bfXvMed8Qk93n81uEb9YBtHK-Pe_EtJSAUYzrfL-g@mail.gmail.com>
References: <alpine.DEB.2.02.1402191824260.8777@utopia.booyaka.com>
 <CANacCWy10TTJenrZ6hdTN8bCpAQQjRa5MOBPde7bnn-LM+VFbw@mail.gmail.com>
 <alpine.DEB.2.02.1402191920040.8777@utopia.booyaka.com>
 <CANacCWxZ8bfXvMed8Qk93n81uEb9YBtHK-Pe_EtJSAUYzrfL-g@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1402192005080.8777@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Feb 2014, Vaibhav Bedia wrote:

> After spending a lot of time looking at the code and PRCM specs for the
> different chips i had come to the conclusion that in reality the Catalog
> parts had the same hardware minus intelligence ;)

Did you look at the RTL?

> The control bits are the same with just the AUTO modes in the PWRDM,
> CLKDM, CLKCTRL never being supported.

I'm not sure it's that simple.  For example PWRSTCTRL/PWRSTST offsets are 
handled very differently between AM335x and the other OMAPs.  Also the 
LOGICRETSTATE mask bits are different.  These unnecessary deltas suggest 
to me that the underlying hardware implementation is different.

I spent some time a few years ago trying to find some hardware guy to give 
some straight answers about the implementation history for the underlying 
blocks, but was never able to find that person.


- Paul
