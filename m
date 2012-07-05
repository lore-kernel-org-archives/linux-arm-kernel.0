From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 05 Jul 2012 13:15:45 +0100
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <20120705120600.GT4111@opensource.wolfsonmicro.com>
References: <1341316788-12730-1-git-send-email-lee.jones@linaro.org>
 <20120703123552.GC25995@sirena.org.uk> <4FF2EEA1.6080204@linaro.org>
 <20120703132447.GN29030@opensource.wolfsonmicro.com>
 <4FF2F82D.9080507@linaro.org>
 <20120703142123.GQ29030@opensource.wolfsonmicro.com>
 <4FF54406.3000307@linaro.org>
 <20120705094541.GK4111@opensource.wolfsonmicro.com>
 <4FF57EA9.7060107@linaro.org>
 <20120705120600.GT4111@opensource.wolfsonmicro.com>
Message-ID: <4FF58571.2090807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/12 13:06, Mark Brown wrote:
> On Thu, Jul 05, 2012 at 12:46:49PM +0100, Lee Jones wrote:
>
>> Besides, the main role of Device Tree is to eradicate platform code.
>> Whereas the code in the MFD driver used to register the AB8500 devices
>> is not platform code.
>
> Right, this is a big part of what I'm saying.
>
>> Does that answer your question better?
>
> Not really, no.

Then you're not asking the right question. :)

>>>> By the way, this patch has nothing to do with registering these
>>>> devices when DT is enabled. The code already does that. This is a
>>>> bug fix, to stop multiple registration of the ab8500 when DT is
>>>> _not_ enabled.
>
>>> Really?  It seems really surprising that adding more DT support to the
>>> MFD core would have any bearing on something like this...
>
>> I'm not really sure what you mean by this.
>
> You seemed to be suggesting that your fix was in some way related to the
> DT changes in the MFD core.  I'm unsure as to the relationship here.

How is it not related? In English the patch would say; "Only register 
the AB8500 via the MFD API when we're booting with Device Tree. This 
allows AB8500 related devices to be registered in the normal way, rather 
than registering them individually using DT and prevents duplicate 
registration when we are not executing a Device Tree enabled boot."


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
