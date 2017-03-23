From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Thu, 23 Mar 2017 16:13:10 +0530
Subject: [PATCH] ARM: nommu: access ID_PFR1 only if CPUID scheme
In-Reply-To: <20170317164034.4036-1-afzal.mohd.ma@gmail.com>
References: <20170317164034.4036-1-afzal.mohd.ma@gmail.com>
Message-ID: <20170323104310.GA6941@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 17, 2017 at 10:10:34PM +0530, afzal mohammed wrote:
> Greg upon trying to boot no-MMU Kernel on ARM926EJ reported boot
> failure. He root caused it to ID_PFR1 access introduced by the
> commit mentioned in the fixes tag below.
> 
> All CP15 processors need not have processor feature registers, only
> for architectures defined by CPUID scheme would have it. Hence check
> for it before accessing processor feature register, ID_PFR1.
> 
> Fixes: f8300a0b5de0 ("ARM: 8647/2: nommu: dynamic exception base address setting")
> Reported-by: Greg Ungerer <gerg@uclinux.org>
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

Greg, can i add your Tested-by ?

Regards
afzal

> ---
> 
> Hi Russell,
> 
> It would be good to have the fix go in during -rc, as,
> 
> 1. Culprit commit went in during the last merge window
> 2. Though nothing supported in mainline is known to be broken, the
>     original change needs to be modified to be reliable
