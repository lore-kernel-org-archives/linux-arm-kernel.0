From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 15 Mar 2017 12:19:48 +0000
Subject: [PATCH 1/7] mfd: syscon: atmel-smc: Add new helpers to ease SMC
 regs manipulation
In-Reply-To: <20170314182117.4c6c2162@bbrezillon>
References: <1487609701-10300-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487609701-10300-2-git-send-email-boris.brezillon@free-electrons.com>
 <20170314170003.nfpc7adtyczvhb26@dell>
 <20170314182117.4c6c2162@bbrezillon>
Message-ID: <20170315121948.ys63ntordjwcm6rb@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Mar 2017, Boris Brezillon wrote:

> On Tue, 14 Mar 2017 17:00:03 +0000
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Mon, 20 Feb 2017, Boris Brezillon wrote:
> > 
> > > These new helpers + macro definitions are meant to replace the old ones
> > > which are unpractical to use.
> > > 
> > > Note that the macros and function prefixes have been intentionally
> > > changed to ATMEL_[H]SMC_XX and atmel_[h]smc_ to reflect the fact that
> > > this IP is also embedded in avr32 SoCs (and not only in at91 ones).  
> > 
> > I'm going to NACK this patch.
> > 
> > I don't see any reason why all those functions have to be inline and
> > shoved into a header file.
> 
> Because those are simple conversion helpers, and I thought a
> dedicated C file was not required, but I can move them into a C file
> and export these functions using EXPORT_SYMBOL_GPL() if you prefer.
> 
> Would that work for you?

I think that would be better TBH.  Those functions aren't all that
simple.  There is certainly too much meat on the bones for me to be
happy for them to be shoved into a header file.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
