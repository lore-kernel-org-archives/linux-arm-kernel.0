From: p.pisati@gmail.com (Paolo Pisati)
Date: Wed, 19 Nov 2014 11:55:27 +0100
Subject: [PATCH V8 00/14] drm/exynos: few patches to enhance bridge chip
 support
In-Reply-To: <546C646C.4060303@collabora.co.uk>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
 <CAEC9eQOrKw2Z1q-ztFfadXmsL3CTcAkkv9kcS2QnDOAVSh2AuQ@mail.gmail.com>
 <546C646C.4060303@collabora.co.uk>
Message-ID: <20141119105527.GA5396@luxor.wired.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 10:35:40AM +0100, Javier Martinez Canillas wrote:
> Hello Ajay,
> 
> On 11/18/2014 07:20 AM, Ajay kumar wrote:
> > On Sat, Nov 15, 2014 at 3:24 PM, Ajay Kumar <ajaykumar.rs@samsung.com> wrote:
> >> This series is based on master branch of Linus tree at:
> >> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
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

do you have this in your dmesg?

...
exynos-dp-video-phy 10040728.video-phy: Failed to lookup PMU regmap
...

to get a working framebuffer out of linus 318rc4 on my peach pi, i had
to cherry pick these 3 patches:

arm: dts: Exynos5: Use pmu_system_controller phandle for dp phy
drm/exynos: dp: Remove support for unused dptx-phy
ARM: exynos_defconfig: Enable options for display panel support

Check if you have those.
-- 
bye,
p.
