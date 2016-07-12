From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jul 2016 11:50:28 +0200
Subject: [PATCH v2 06/10] soc: Add SoC specific driver support for nuc900
In-Reply-To: <5784B302.80307@iommu.org>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
 <4765191.NGpMC1JR46@wuerfel> <5784B302.80307@iommu.org>
Message-ID: <1510379.YVtTfMI32O@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 12, 2016 5:06:10 PM CEST Wan Zongshun wrote:
> On 2016?07?11? 16:03, Arnd Bergmann wrote:
> > On Sunday, July 10, 2016 3:27:26 PM CEST Wan Zongshun wrote:
> > I'm still a bit unsure about the set of attributes here.
> >
> > - The "soc_id" is read from the device tree from the field that contains
> >    the board name, I think for consistency you should try to map the
> >    GCR_CHIPID to the name of the SoC and assign that here
> >
> > - The "machine" is hardcoded to "NUC900EVB", which in turn looks like
> >    a particular board but not the one you are running on. Maybe read
> >    that from the DT instead?
> >
> > - The "revision" is not filled at all, I would suggest using something
> >    derived from the GCR_CHIPID register here
> >
> > - you have two nonstandard attributes "chipid" and "version", which
> >    I'd hope to avoid -- the set of standard attributes is supposed to
> >    give enough information about the machine, and platform independent
> >    user space will never read those.
> 
> So, Maybe I can remove those two codes, no need push those information 
> to user space?
> 
> device_create_file(soc_device_to_device(soc_dev), &nuc900_chipid_attr);
> device_create_file(soc_device_to_device(soc_dev), &nuc900_version_attr);
> 

Yes, that would be good.

	Arnd
