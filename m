From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 14 Mar 2017 18:21:17 +0100
Subject: [PATCH 1/7] mfd: syscon: atmel-smc: Add new helpers to ease SMC
 regs manipulation
In-Reply-To: <20170314170003.nfpc7adtyczvhb26@dell>
References: <1487609701-10300-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487609701-10300-2-git-send-email-boris.brezillon@free-electrons.com>
 <20170314170003.nfpc7adtyczvhb26@dell>
Message-ID: <20170314182117.4c6c2162@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Mar 2017 17:00:03 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> On Mon, 20 Feb 2017, Boris Brezillon wrote:
> 
> > These new helpers + macro definitions are meant to replace the old ones
> > which are unpractical to use.
> > 
> > Note that the macros and function prefixes have been intentionally
> > changed to ATMEL_[H]SMC_XX and atmel_[h]smc_ to reflect the fact that
> > this IP is also embedded in avr32 SoCs (and not only in at91 ones).  
> 
> I'm going to NACK this patch.
> 
> I don't see any reason why all those functions have to be inline and
> shoved into a header file.

Because those are simple conversion helpers, and I thought a
dedicated C file was not required, but I can move them into a C file
and export these functions using EXPORT_SYMBOL_GPL() if you prefer.

Would that work for you?
