From: liu.y.victor@gmail.com (Liu Ying)
Date: Thu, 14 May 2015 10:10:54 +0800
Subject: [PATCH RFC v9.5 09/20] drm/dsi: Add a helper to get bits per
 pixel of MIPI DSI pixel format
In-Reply-To: <20150512133620.GA24939@ulmo.nvidia.com>
References: <1423805119-32008-1-git-send-email-Ying.Liu@freescale.com>
 <20150512133620.GA24939@ulmo.nvidia.com>
Message-ID: <CA+8Hj82h1wFdEex3JLdiWC0pfUT6j5wui34ca+CRXeHeycYUNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-12 21:36 GMT+08:00 Thierry Reding <thierry.reding@gmail.com>:
> On Fri, Feb 13, 2015 at 01:25:19PM +0800, Liu Ying wrote:
>> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
>
> This could use a commit message. Describe for example why this is useful
> or when to use it.

Ok, I'll add it in the next version.

>
>> ---
>> v9->v9.5:
>>  * Add kernel-doc for the new helper function to address Daniel Vetter's
>>    comment.
>>
>> v8->v9:
>>  * Rebase onto the imx-drm/next branch of Philipp Zabel's open git repository.
>>
>> v7->v8:
>>  * None.
>>
>> v6->v7:
>>  * None.
>>
>> v5->v6:
>>  * Address the over 80 characters in one line warning reported by the
>>    checkpatch.pl script.
>>
>> v4->v5:
>>  * None.
>>
>> v3->v4:
>>  * None.
>>
>> v2->v3:
>>  * None.
>>
>> v1->v2:
>>  * Thierry Reding suggested that the mipi_dsi_pixel_format_to_bpp() function
>>    could be placed at the common DRM MIPI DSI driver.
>>    This patch is newly added.
>>
>>  include/drm/drm_mipi_dsi.h | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
>> index f1d8d0d..cabc910 100644
>> --- a/include/drm/drm_mipi_dsi.h
>> +++ b/include/drm/drm_mipi_dsi.h
>> @@ -163,6 +163,28 @@ static inline struct mipi_dsi_device *to_mipi_dsi_device(struct device *dev)
>>       return container_of(dev, struct mipi_dsi_device, dev);
>>  }
>>
>> +/**
>> + * mipi_dsi_pixel_format_to_bpp() - get bits per pixel for a mipi dsi
>> + *    pixel format
>> + * @fmt: mipi dsi pixel format
>> + *
>> + * Return: The bits per pixel value for the mipi dsi pixel format on success or
>> + *    a negative error code on failure.
>> + */
>
> s/mipi dsi/MIPI DSI/, please.

Ok.

Thanks,
Liu Ying

>
> Thierry
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>



-- 
Best Regards,
Liu Ying
