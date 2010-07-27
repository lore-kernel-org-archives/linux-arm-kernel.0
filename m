From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 27 Jul 2010 01:22:36 -0600 (MDT)
Subject: [PATCH 12/20] OMAP: PM: create omap_devices for MPU, DSP, L3
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0323C3F32F@dbde02.ent.ti.com>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
	<20100702152930.6221.32877.stgit@localhost.localdomain>
	<5A47E75E594F054BAF48C5E4FC4B92AB0323A2C2A5@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0323C3F32F@dbde02.ent.ti.com>
Message-ID: <alpine.DEB.2.00.1007270121350.1906@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thara,

On Sat, 24 Jul 2010, Gopinath, Thara wrote:

> >>>>+struct device *omap2_get_dsp_device(void)
> >>>>+{
> >>>>+	WARN_ON_ONCE(!dsp_dev);
> >>>>+	return dsp_dev;
> >>>>+}
> >>First of all, apologies for so late posting of the comment. IMHO it would be good to rename this API
> >>as omap2_get_iva_device. This is because OMAP4 has separate IVA and DSP devices and we will need to
> >>build the omap_device for both. If we could rename this as omap2_get_iva_device, we could introduce
> >>another API omap4_get_iva_device until bridge starts doing a omap_device_build for all these devices.
> 
> Hello Paul,
> 
> Any thoughts on this one?

Makes sense to me.  Probably we should queue a patch up to fix that for 
2.6.37...


- Paul
