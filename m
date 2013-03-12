From: cstsai@itri.org.tw (cstsai)
Date: Tue, 12 Mar 2013 09:49:51 +0800
Subject: [PATCH v8 3/7] ARM: davinci: Add support for
 configuringDA8XX_REMOTEPROC
References: <1362782508-3166-1-git-send-email-rtivy@ti.com><1362782508-3166-4-git-send-email-rtivy@ti.com>	<513DC4A1.8020700@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C143121BDA8@DFLE08.ent.ti.com>
Message-ID: <E78723D735DE45359449DC4823132BD2@520A0002602>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sir,

Please don't send update emails to me

Whenever I need I can check from website

Thanks & Regards,
cstsai

----- Original Message ----- 
From: "Tivy, Robert" <rtivy@ti.com>
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: <ohad@wizery.com>; <davinci-linux-open-source@linux.davincidsp.com>; 
<stable@vger.kernel.org>; <linux-arm-kernel@lists.infradead.org>
Sent: Tuesday, March 12, 2013 4:26 AM
Subject: RE: [PATCH v8 3/7] ARM: davinci: Add support for 
configuringDA8XX_REMOTEPROC


> -----Original Message-----
> From: Nori, Sekhar
> Sent: Monday, March 11, 2013 4:49 AM
>
> On 3/9/2013 4:11 AM, Robert Tivy wrote:
> > Also fix REMOTEPROC config to select FW_LOADER (instead of
> FW_CONFIG).
>
> It is preferable to have the patch description make sense standalone
> even when read without the subject line.

Will fix.

>
> >
> > Signed-off-by: Robert Tivy <rtivy@ti.com>
>
> Please follow the subject line conventions of the subsystem the patch
> is
> touching. This is not an ARM patch so the "ARM: davinci: " prefix in
> subject is surely wrong.

So even though it is a driver for just DA8XX, it should not get the "ARM: 
davinci:" prefix?

Is that mandated by the fact that it's in a general "driver" subdirectory?

>
> And I think I mentioned this once before but we want to see
> Kconfig/Makefile changes along with driver addition in the same patch.

Yeah, I was confusing Ohad's feedback about the "fix" to Kconfig being in a 
separate patch.  I will therefore put the "fix" (FW_CONFIG -> FW_LOADER) 
into its own patch, and group the driver's Kconfig additions with the driver 
and its Makefile.

>
> > ---
> >  drivers/remoteproc/Kconfig |   26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index 96ce101..21d04f1 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -5,7 +5,7 @@ config REMOTEPROC
> >  tristate
> >  depends on EXPERIMENTAL
> >  depends on HAS_DMA
> > - select FW_CONFIG
> > + select FW_LOADER
> >  select VIRTIO
> >
> >  config OMAP_REMOTEPROC
> > @@ -41,4 +41,28 @@ config STE_MODEM_RPROC
> >    This can be either built-in or a loadable module.
> >    If unsure say N.
> >
> > +config DA8XX_REMOTEPROC
> > + tristate "DA830/OMAPL137 & DA850/OMAPL138 remoteproc support
> (EXPERIMENTAL)"
> > + depends on ARCH_DAVINCI_DA8XX
> > + select REMOTEPROC
> > + select RPMSG
> > + select CMA
>
> Its nice to keep the selects sorted. It helps avoid duplicates.

Will fix.

>
> > + default n
>
> No need of this I think, it should default to no already.

OK.

>
> > + help
> > +   Say y here to support DA830/OMAPL137 & DA850/OMAPL138 remote
> > +   processors via the remote processor framework.
> > +
> > +   You want to say y here in order to enable AMP
> > +   use-cases to run on your platform (multimedia codecs are
> > +   offloaded to remote DSP processors using this framework).
> > +
> > +   This module controls the name of the firmware file that gets
> > +   loaded on the DSP.  This file must reside in the /lib/firmware
> > +   directory.  It can be specified via the module parameter
> > +   da8xx_fw_name=<filename>, and if not specified will default to
> > +   "rproc-dsp-fw".
>
> I hope running modinfo gives these details as well.

It will in the next patch :)

>
> > +
> > +   It's safe to say n here if you're not interested in multimedia
> > +   offloading or just want a bare minimum kernel.
>
> I think this is misleading a bit since just selecting 'n' here will not
> result in a "bare minimum kernel" - better to just avoid mention of it.

Agreed, will drop.

>
> Thanks,
> Sekhar

Thanks & Regards,

- Rob

_______________________________________________
Davinci-linux-open-source mailing list
Davinci-linux-open-source at linux.davincidsp.com
http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source 

====================================================================
This email may contain confidential information. Please do not use or disclose it in any way and delete it if you are not the intended recipient.
