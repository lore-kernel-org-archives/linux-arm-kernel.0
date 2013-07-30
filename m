From: balbi@ti.com (Felipe Balbi)
Date: Tue, 30 Jul 2013 16:18:37 +0300
Subject: [PATCH v2 1/8] ARM: DRA7: id: Add cpu detection support for
 DRA7xx based SoCs'
In-Reply-To: <20130730131009.GA28162@radagast>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
 <1375183546-12758-2-git-send-email-rnayak@ti.com>
 <20130730131009.GA28162@radagast>
Message-ID: <20130730131837.GB28162@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 04:10:09PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Jul 30, 2013 at 04:55:39PM +0530, Rajendra Nayak wrote:
> > @@ -379,6 +407,13 @@ IS_OMAP_TYPE(3430, 0x3430)
> >  # define soc_is_omap543x()		is_omap543x()
> >  #endif
> >  
> > +# if defined(CONFIG_SOC_DRA7XX)
> > +# undef soc_is_dra7xx
> > +# undef soc_is_dra75x
> > +# define soc_is_dra7xx()		is_dra7xx()
> > +# define soc_is_dra75x()		is_dra75x()
> 
> since this platform is DT-only, couldn't we just believe DT-data to be
> correct of_machine_is_compatible() ? 2/3 of this patch would be removed.

s/correct of_/correct and use of_

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/0afe06d3/attachment.sig>
