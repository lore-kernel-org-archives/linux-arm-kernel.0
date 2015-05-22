From: bp@alien8.de (Borislav Petkov)
Date: Fri, 22 May 2015 10:46:25 +0200
Subject: [PATCH v10 4/5] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <4456746.y9FVaqRogk@wuerfel>
References: <1431991481-25684-1-git-send-email-lho@apm.com>
 <1431991481-25684-4-git-send-email-lho@apm.com>
 <1431991481-25684-5-git-send-email-lho@apm.com>
 <4456746.y9FVaqRogk@wuerfel>
Message-ID: <20150522084625.GE23022@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 10:23:11AM +0200, Arnd Bergmann wrote:
> > +static int edac_mc_idx;
> > +static int edac_mc_active_mask;
> > +static int edac_mc_registered_mask;
> > +static DEFINE_MUTEX(xgene_edac_mc_lock);
> 
> It would also be best to avoid global variables, but it seems that at
> least the edac_mc_idx is needed to work with the EDAC subsystem.
> Maybe Boris has an idea for how to avoid it.

Right, so AFAICT this is used in

	edac_mc_alloc(edac_mc_idx++

and basically we're supplying the memory controller numbers in the order
we're calling xgene_edac_mc_add(). Perhaps we need to make the memory
controller numbering explicit with DT...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
