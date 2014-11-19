From: ajaynumb@gmail.com (Ajay kumar)
Date: Wed, 19 Nov 2014 15:08:59 +0530
Subject: [PATCH V8 00/14] drm/exynos: few patches to enhance bridge chip
 support
In-Reply-To: <546C646C.4060303@collabora.co.uk>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
 <CAEC9eQOrKw2Z1q-ztFfadXmsL3CTcAkkv9kcS2QnDOAVSh2AuQ@mail.gmail.com>
 <546C646C.4060303@collabora.co.uk>
Message-ID: <CAEC9eQPz_7QeL7EDorb-OxiTjcb1tVUDbEbzbER4Yu2wSNNaxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

In the cover letter, I have mentioned that it is tested on Linus tree:

"This series is based on master branch of Linus tree at:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"

Kindly test the patches with that.

Ajay

On Wed, Nov 19, 2014 at 3:05 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Hello Ajay,
>
> On 11/18/2014 07:20 AM, Ajay kumar wrote:
>> On Sat, Nov 15, 2014 at 3:24 PM, Ajay Kumar <ajaykumar.rs@samsung.com> wrote:
>>> This series is based on master branch of Linus tree at:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>
> I applied your series on top of 3.18-rc5 + linux-next's commit:
>
> 0ef76ae ("ARM: exynos_defconfig: Enable options for display panel support").
>
> I think you should had mentioned what other patches are needed as a
> dependency since I spent quite a bit of time figuring out why the
> ps8622 bridge driver probe was always deferred due of_drm_find_panel()
> failing and then I noticed that a patch from linux-next was needed:
>
> e35e305 ("drm/panel: simple: Add AUO B116XW03 panel support")
>
> With that commit the ps8622 drm bridge driver probe succeed but I still
> don't have display working on an Exynos5240 Peach Pit, the kernel log shows:
>
> platform 145b0000.dp-controller: Driver exynos-dp requests probe deferral
> exynos-drm exynos-drm: bound 14400000.fimd (ops fimd_component_ops)
> exynos-drm exynos-drm: failed to bind 145b0000.dp-controller (ops exynos_dp_ops): -517
> exynos-drm exynos-drm: master bind failed: -517
> platform 145b0000.dp-controller: Driver exynos-dp requests probe deferral
>
> Any idea what else I could be missing here?
>
> Your patches don't apply cleanly in linux-next btw, although the are many
> issues with the Exynos DRM currently in linux-next anyways so probably using
> 3.18-rc as a base makes more sense for now until all those things get fixed
> but you should rebase so they can be picked.
>
> Best regards,
> Javier
