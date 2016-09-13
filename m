From: brian.starkey@arm.com (Brian Starkey)
Date: Tue, 13 Sep 2016 15:13:02 +0100
Subject: [PATCH 2/3] drm: add ARM vendor format afbc
In-Reply-To: <1473474544-16248-2-git-send-email-mark.yao@rock-chips.com>
References: <1473474544-16248-1-git-send-email-mark.yao@rock-chips.com>
 <1473474544-16248-2-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20160913141302.GA30625@e106950-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Sat, Sep 10, 2016 at 10:29:03AM +0800, Mark Yao wrote:
>AFBC is arm vendor format, it's a compressed format.
>
>The AFBC format is supported by rk3399 vop big.
>
>We know little about AFBC layout, hope to some guys can
>fixme about the afbc comment.
>
>Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>---
> include/uapi/drm/drm_fourcc.h | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
>index a5890bf..9a47d7e 100644
>--- a/include/uapi/drm/drm_fourcc.h
>+++ b/include/uapi/drm/drm_fourcc.h
>@@ -159,6 +159,7 @@ extern "C" {
> #define DRM_FORMAT_MOD_VENDOR_NV      0x03
> #define DRM_FORMAT_MOD_VENDOR_SAMSUNG 0x04
> #define DRM_FORMAT_MOD_VENDOR_QCOM    0x05
>+#define DRM_FORMAT_MOD_VENDOR_ARM     0x06
> /* add more to the end as needed */
>
> #define fourcc_mod_code(vendor, val) \
>@@ -233,6 +234,12 @@ extern "C" {
>  */
> #define DRM_FORMAT_MOD_SAMSUNG_64_32_TILE	fourcc_mod_code(SAMSUNG, 1)
>
>+/*
>+ * FIXME: AFBC is arm vendor format, it's a compressed format.
>+ *
>+ */
>+#define DRM_FORMAT_MOD_ARM_AFBC	fourcc_mod_code(ARM, 1)

Do you have any details about the exact type of AFBC data you are
consuming here?

We need to agree what exactly a buffer with the modifier
"DRM_FORMAT_MOD_ARM_AFBC" means. For instance the block size, whether
the data has the YUV transform applied, how the data is laid out in
memory etc.

We (ARM) want to make sure that the format modifiers we expose to
userspace for AFBC are precise and non-ambiguous, cover all
possible AFBC modifiers (of which there are many, and the list can
only get longer) and all possible AFBC consuming/producing IPs'
requirements.

We had intended to delay adding any AFBC format modifiers to DRM until
we'd had this kind of discussion internally to agree the exact set
of modifiers we need, but if you need this now then we can start that 
discussion here.

Thanks,
Brian

>+
> #if defined(__cplusplus)
> }
> #endif
>-- 
>1.9.1
>
>
>_______________________________________________
>dri-devel mailing list
>dri-devel at lists.freedesktop.org
>https://lists.freedesktop.org/mailman/listinfo/dri-devel
