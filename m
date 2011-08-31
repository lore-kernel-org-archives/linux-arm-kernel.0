From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Wed, 31 Aug 2011 11:28:28 +0900
Subject: [RFC][PATCH v3] DRM: add DRM Driver for Samsung SoC EXYNOS4210.
In-Reply-To: <CAF6AEGu3ss-rJC28H1rm2GWLm1bAZnHLftXfMLJQNeqjBt3umQ@mail.gmail.com>
References: <1314359274-21585-1-git-send-email-inki.dae@samsung.com>
	<CAF6AEGu3ss-rJC28H1rm2GWLm1bAZnHLftXfMLJQNeqjBt3umQ@mail.gmail.com>
Message-ID: <4E5D9C4C.1090808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +static void samsung_drm_connector_destroy(struct drm_connector *connector)
>> +{
>> +       struct samsung_drm_connector *samsung_connector =
>> +               to_samsung_connector(connector);
>> +
>> +       DRM_DEBUG_KMS("%s\n", __FILE__);
>> +
>> +       drm_sysfs_connector_remove(connector);
>> +       drm_connector_cleanup(connector);
>> +       connector->dev->mode_config.num_connector--;
>
> I wonder if num_connector-- should be in drm_connector_cleanup()..
>

Right, num_connector and num_encoder of mode_config should be decreased
in the cleanup functions, but currently drm driver is missing it.

I sent the patch.

Thanks.
