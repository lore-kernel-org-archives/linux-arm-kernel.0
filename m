From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 22 Mar 2011 15:05:07 +0530
Subject: [PATCH v3 1/7] mfd: add pruss mfd driver.
In-Reply-To: <20110318123917.GC27129@sirena.org.uk>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
	<1299592667-21367-2-git-send-email-subhasish@mistralsolutions.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C3B85A5@dbde02.ent.ti.com>
	<20110318123917.GC27129@sirena.org.uk>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C47D5EE@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Mar 18, 2011 at 18:09:17, Mark Brown wrote:
> On Fri, Mar 18, 2011 at 05:29:39PM +0530, Nori, Sekhar wrote:
> 
> > PRUSS as an IP is not really tied to the DA8xx SoC architecture.
> > So, can you please name the files ti-pruss* or even just pruss if
> > MFD folks are okay with it?
> 
> This...
> 
> > > +EXPORT_SYMBOL(pruss_get_clk_freq);
> 
> > This looks strange. Why do we need this? There
> > is clk_get_rate() API in the kernel would would
> > seem more suitable.
> 
> ...unfortunately conflicts with this - currently all clock API
> implementations are unique to the platform and there's no way of adding
> clocks that works over multiple platforms.

Hmm, I guess I have a limited view of this. We do have drivers which
use clock API and work across OMAP and DaVinci series of ARM SoCs.
The clock implementation in this case is under mach-omap and mach-davinci
respectively.

Thanks,
Sekhar
