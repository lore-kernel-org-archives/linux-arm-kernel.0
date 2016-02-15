From: CARLOS.PALMINHA@synopsys.com (Carlos Palminha)
Date: Mon, 15 Feb 2016 12:29:00 +0000
Subject: [PATCH 01/17] drm/virtio: removed optional dummy encoder
 mode_fixup function.
In-Reply-To: <20160214182508.GF11240@phenom.ffwll.local>
References: <daniel.vetter@ffwll.ch,>
 <1455285069-2819-1-git-send-email-palminha@synopsys.com>
 <1455285069-2819-2-git-send-email-palminha@synopsys.com>
 <20160214182508.GF11240@phenom.ffwll.local>
Message-ID: <56C1C48C.1050006@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel, thanks for the feedback.
v2 patch will follow-up. :)

On 14-02-2016 18:25, Daniel Vetter wrote:
> On Fri, Feb 12, 2016 at 01:50:53PM +0000, Carlos Palminha wrote:
>
> Sob-line from you is missing on all patches, I can't merge them. Also
> please copypaste a default blurb to all patches that this is only recently
> no longer needed. And dunno what happened to your patch series, the
> threading is somehow broken. In case your mail server doesn't accept a big
> patch series you can first format .patch files using git format-patch with
> threading enabled (should be the default) and then send them out in
> chunks.
>
> When resending please also add the r-b tag from Alex for amdgpu/radoen.
>
> Thanks, Daniel
>
>> ---
>>   drivers/gpu/drm/virtio/virtgpu_display.c | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
>> index a165f03..429aa31 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
>> @@ -282,13 +282,6 @@ static const struct drm_crtc_helper_funcs virtio_gpu_crtc_helper_funcs = {
>>   	.atomic_check  = virtio_gpu_crtc_atomic_check,
>>   };
>>
>> -static bool virtio_gpu_enc_mode_fixup(struct drm_encoder *encoder,
>> -				      const struct drm_display_mode *mode,
>> -				      struct drm_display_mode *adjusted_mode)
>> -{
>> -	return true;
>> -}
>> -
>>   static void virtio_gpu_enc_mode_set(struct drm_encoder *encoder,
>>   				    struct drm_display_mode *mode,
>>   				    struct drm_display_mode *adjusted_mode)
>> @@ -362,7 +355,6 @@ virtio_gpu_best_encoder(struct drm_connector *connector)
>>   }
>>
>>   static const struct drm_encoder_helper_funcs virtio_gpu_enc_helper_funcs = {
>> -	.mode_fixup = virtio_gpu_enc_mode_fixup,
>>   	.mode_set   = virtio_gpu_enc_mode_set,
>>   	.enable     = virtio_gpu_enc_enable,
>>   	.disable    = virtio_gpu_enc_disable,
>> --
>> 2.5.0
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel at lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
