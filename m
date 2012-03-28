From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 28 Mar 2012 13:10:55 +0900
Subject: [PATCH 2/2] ARM: lib: use LDRD/STRD for data copy
In-Reply-To: <012d01cd0c78$7d2f19a0$778d4ce0$%kim@samsung.com>
References: <007201cd059e$4af2cc10$e0d86430$%kim@samsung.com>
 <00d501cd0bb0$724ab260$56e01720$%kim@samsung.com>
 <20120327074039.GJ5611@n2100.arm.linux.org.uk>
 <012d01cd0c78$7d2f19a0$778d4ce0$%kim@samsung.com>
Message-ID: <014e01cd0c98$c5e899d0$51b9cd70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boojin Kim wrote:
> > Cc: linux-arm-kernel at lists.infradead.org; 'Catalin Marinas'; 'Nicolas Pitre';
> > kgene.kim at samsung.com
> > Subject: Re: [PATCH 2/2] ARM: lib: use LDRD/STRD for data copy
> >
> > On Tue, Mar 27, 2012 at 09:27:52AM +0900, Boojin Kim wrote:
> > > This patch uses LDRD/STRD that loads and stores data as DWORD unit.
> > > It brings better performance than LDRM/STRM with cortex-a15.
> >
> > Why should I bother looking at this rubbish?  You've been told before
> > that using ldrd and strd unconditionally is not acceptable.  Stop
> > wasting peoples review time.
> This patch brings better memcpy results on Cortex-a15.
Additionally, Following is ARM's memcpy implementation that mentions LDRD/STRD is better for cortex-a15.
http://sourceware.org/ml/newlib/2011/msg00469.html
I'm tring to optimize memcpy for cortex-a15 because it's seems to be worth.
Thank you..

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
