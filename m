From: denis@eukrea.com (Denis Carikli)
Date: Tue, 08 Apr 2014 10:08:42 +0200
Subject: [PATCH v12][ 07/12] drm: drm_display_mode: add signal polarity
 flags
In-Reply-To: <534398D5.4090600@samsung.com>
References: <1396874691-27954-1-git-send-email-denis@eukrea.com>
 <1396874691-27954-7-git-send-email-denis@eukrea.com>
 <534398D5.4090600@samsung.com>
Message-ID: <5343AE8A.50803@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2014 08:36 AM, Andrzej Hajda wrote:
>
> Hi Denis,
Hi,

>> +#define DRM_MODE_FLAG_POL_PIXDATA_NEGEDGE	BIT(1)
>> +#define DRM_MODE_FLAG_POL_PIXDATA_POSEDGE	BIT(2)
>> +#define DRM_MODE_FLAG_POL_PIXDATA_PRESERVE	BIT(3)
>
> What is the purpose of DRM_MODE_FLAG_POL_PIXDATA_PRESERVE?
> If 'preserve' means 'ignore' we can set to zero negedge and posedge bits
> instead of adding new bit. If it is something different please describe it.
Yes, it meant 'ignore'.

The goal was to be able to have a way to keep the old behavior while 
still being able to set the flags.

So, with the imx-drm driver, if none of the DRM_MODE_FLAG_POL_PIXDATA 
were set(that is POSEDGE, NEGEDGE, PRESERVE), then in ipuv3-crtc.c, it 
went using the old flags settings that were previously hardcoded.

The same applied for DRM_MODE_FLAG_POL_DE.
The patch using theses flags is the 08/12 of this same serie.

>>   struct drm_display_mode {
[..]
>> +	unsigned int pol_flags;
>
> Adding field and macros description to the DocBook would be nice.
So I will have to describe it in the "Connector Helper Operations" 
section of drm.tmpl, right before the mode_valid synopsis ?

Denis.
