From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 12 Nov 2013 18:47:30 +0000
Subject: Physical memory start contraints in the Linux kernel (Was: Re:
 Xen osstest on Calxeda midway progress (Was: Re: [Xen-devel] [xen-unstable
 test] 21486: tolerable FAIL - PUSHED))
In-Reply-To: <201311121939.08971.arnd@arndb.de>
References: <osstest-21486-mainreport@xen.org> <52823C9E.2010007@linaro.org>
 <1384267233.10204.20.camel@kazak.uk.xensource.com>
 <201311121939.08971.arnd@arndb.de>
Message-ID: <alpine.DEB.2.02.1311121843230.26077@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Nov 2013, Arnd Bergmann wrote:
> On Tuesday 12 November 2013, Ian Campbell wrote:
> > On Tue, 2013-11-12 at 14:35 +0000, Julien Grall wrote:
> > > On 11/12/2013 01:37 PM, Arnd Bergmann wrote:
> > > > BTW, does Dom0 require an LPAE-enabled kernel or can it be a regular
> > > > non-LPAE ARMv6/v7 multiplatform build?
> > > 
> > > It can be both.
> > 
> > NB: v7 only, we don't do v6 at all. But yes either LPAE or regular is
> > fine with us.
> 
> Why not combined v6/v7 kernels for non-LPAE? I can't see a technical reason
> preventing you from running a Dom0 or DomU kernel that can also run on
> some ARMv6 platform as long as both platforms and CPUs are enabled in
> Kconfig.

Unfortunately today we can't support ARMv6.
>From f880b67dcbdedb49453f88d2ccb1a0937b046d82:
   
    * ARMv6 does not support cmpxchg on 16-bit words that are used in the
      Xen grant table code, so we must ensure that Xen support is only
      built on ARMv7-only kernels not combined ARMv6/v7 kernels.
