From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Sun, 4 Nov 2012 15:26:16 +0000
Subject: [PATCH 08/15] ARM: OMAP2+: hwmod: Fix the omap_hwmod_addr_space
 for CPGMAC0
In-Reply-To: <509543E8.60209@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-9-git-send-email-vaibhav.bedia@ti.com>
 <509543E8.60209@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFFD33@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2012 at 21:48:48, Shilimkar, Santosh wrote:
> On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> > The first entry for CPGMAC0 should be ADDR_MAP_ON_INIT
> > instead of ADDR_TYPE_RT to ensure the omap hwmod code
> > maps the memory space at init and writes to the SYSCONFIG
> > registers.
> >
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > ---
> Sorry again similar question.
> 
> Why CPGMAC0 should be mapped and sysconfig updated early ?
> 

Hmm I need to revisit this one. CPGMAC0 was not going to standby
without this. Maybe something else is wrong in the hwmod data and
needs fixing.

Regards,
Vaibhav
