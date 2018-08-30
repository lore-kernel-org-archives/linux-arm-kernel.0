From: wufan@codeaurora.org (wufan)
Date: Thu, 30 Aug 2018 08:20:32 -0600
Subject: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <20180830104307.GC20005@nazgul.tnic>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
 <20180830104307.GC20005@nazgul.tnic>
Message-ID: <000901d4406c$9d04f360$d70eda20$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris, 
 
> If we're going to do this, it needs to be tested on an x86 box which loads
> ghes_edac. Adding Toshi to Cc.
> 
> Otherwise it must remain ARM-specific.

Toshi it would be great if you can help! I'll also test the change in x86 but
not sure if the firmware updates module_handle.

> > +static int ghes_edac_dimm_index(u16 handle)
> 
> get_dimm_smbios_handle()

This function returns an index. So how about get_dimm_smbios_index()?

> > +{
> > +	struct mem_ctl_info *mci;
> > +	int i;
> > +
> > +	if (!ghes_pvt)
> > +		return -1;
> 
> You don't need that test.

Will remove.
 
> > +
> > +	mci = ghes_pvt->mci;
> > +
> > +	if (!mci)
> > +		return -1;
> 
> Ditto.

Will remove

Thanks,
Fan
