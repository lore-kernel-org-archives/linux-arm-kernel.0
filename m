From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 6 Jun 2013 13:41:05 -0400 (EDT)
Subject: [PATCH v2] ARM: errata: LoUIS bit field in CLIDR register is
 incorrect
In-Reply-To: <alpine.LFD.2.03.1306061338030.18597@syhkavp.arg>
References: <1370538602.3695.71.camel@linaro1.home>
 <alpine.LFD.2.03.1306061338030.18597@syhkavp.arg>
Message-ID: <alpine.LFD.2.03.1306061340150.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Jun 2013, Nicolas Pitre wrote:

> On Thu, 6 Jun 2013, Jon Medhurst (Tixy) wrote:
> 
> > On Cortex-A9 before version r1p0, the LoUIS bit field of the CLIDR
> > register returns zero when it should return one. This leads to cache
> > maintenance operations which rely on this value to not function as
> > intended, causing data corruption.
> > 
> > The workaround for this errata is to detect affected CPUs and correct
> > the LoUIS value read.
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> This wouldn't hurt adding 'CC: stable at kernel.org' as well.

"stable at vger.kernel.org" that is.


Nicolas
