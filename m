From: inki.dae@samsung.com (Inki Dae)
Date: Mon, 05 Jun 2017 10:33:50 +0900
Subject: exynos drm build failure due to cec_* symbols
In-Reply-To: <2d6226cf-4023-2a97-0791-42d3e8dcbdd3@suse.de>
References: <CGME20170602135819epcas1p2302294dec8c40b69a19e0b220806eacb@epcas1p2.samsung.com>
 <2d6226cf-4023-2a97-0791-42d3e8dcbdd3@suse.de>
Message-ID: <5934B4FE.6060606@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



2017? 06? 02? 22:58? Andreas F?rber ?(?) ? ?:
> Hello,
> 
> We're observing the following build failure with v4.12-rc3, latest
> linux.git and linux-next.git:
> 
> [ 9825s]   LD      vmlinux.o
> [ 9904s]   MODPOST vmlinux.o
> [ 9915s] drivers/built-in.o: In function `hdmi_get_modes':
> [ 9915s]
> /home/abuild/rpmbuild/BUILD/kernel-vanilla-4.12.rc3.51.ga374846/linux-4.12-rc3-51-ga374846/linux-obj/../drivers/gpu/drm/exynos/exynos_hdmi.c:866:
> undefined reference to `cec_notifier_set_phys_addr_from_edid'
> [ 9915s] drivers/built-in.o: In function `hdmi_remove':
> [ 9915s]
> /home/abuild/rpmbuild/BUILD/kernel-vanilla-4.12.rc3.51.ga374846/linux-4.12-rc3-51-ga374846/linux-obj/../drivers/gpu/drm/exynos/exynos_hdmi.c:1923:
> undefined reference to `cec_notifier_set_phys_addr'
> [ 9915s]
> /home/abuild/rpmbuild/BUILD/kernel-vanilla-4.12.rc3.51.ga374846/linux-4.12-rc3-51-ga374846/linux-obj/../drivers/gpu/drm/exynos/exynos_hdmi.c:1927:
> undefined reference to `cec_notifier_put'
> [ 9915s] drivers/built-in.o: In function `hdmi_probe':
> [ 9915s]
> /home/abuild/rpmbuild/BUILD/kernel-vanilla-4.12.rc3.51.ga374846/linux-4.12-rc3-51-ga374846/linux-obj/../drivers/gpu/drm/exynos/exynos_hdmi.c:1889:
> undefined reference to `cec_notifier_get'
> [ 9915s]
> /home/abuild/rpmbuild/BUILD/kernel-vanilla-4.12.rc3.51.ga374846/linux-4.12-rc3-51-ga374846/linux-obj/../drivers/gpu/drm/exynos/exynos_hdmi.c:1904:
> undefined reference to `cec_notifier_put'
> [ 9915s] drivers/built-in.o: In function `hdmi_disable':
> [ 9915s]
> /home/abuild/rpmbuild/BUILD/kernel-vanilla-4.12.rc3.51.ga374846/linux-4.12-rc3-51-ga374846/linux-obj/../drivers/gpu/drm/exynos/exynos_hdmi.c:1509:
> undefined reference to `cec_notifier_set_phys_addr'
> [ 9915s] drivers/built-in.o: In function `hdmi_detect':
> [ 9915s]
> /home/abuild/rpmbuild/BUILD/kernel-vanilla-4.12.rc3.51.ga374846/linux-4.12-rc3-51-ga374846/linux-obj/../drivers/gpu/drm/exynos/exynos_hdmi.c:827:
> undefined reference to `cec_notifier_set_phys_addr'
> [ 9931s] make[2]: ***
> [/home/abuild/rpmbuild/BUILD/kernel-vanilla-4.12.rc3.51.ga374846/linux-4.12-rc3-51-ga374846/Makefile:997:
> vmlinux] Error 1
> [ 9931s] make[1]: *** [Makefile:152: sub-make] Error 2
> [ 9931s] make: *** [Makefile:24: __sub-make] Error 2
> 
> My guess is the symbols used by the exynos drm module are not exported:
> 
> cec_notifier_set_phys_addr_from_edid
> cec_notifier_set_phys_addr
> cec_notifier_put
> cec_notifier_get
> 
> Can you please look into fixing this?

Thanks for reporting.

Will check and fix it.

Thanks,
Inki Dae

> 
> Configs for reproducing are available here:
> 
> v4.12-rc3:
> http://kernel.opensuse.org/cgit/kernel-source/tree/config/armv7hl/default
> http://kernel.opensuse.org/cgit/kernel-source/tree/config/armv7hl/lpae
> 
> linux.git:
> http://kernel.opensuse.org/cgit/kernel-source/tree/config/armv7hl/vanilla?h=vanilla
> 
> linux-next.git:
> http://kernel.opensuse.org/cgit/kernel-source/tree/config/armv7hl/vanilla?h=linux-next
> 
> Thanks,
> Andreas
> 
