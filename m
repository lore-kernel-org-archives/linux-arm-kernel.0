From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Feb 2015 10:21:19 -0700
Subject: [PATCH] ARM: kexec: Relax SMP validation to improve DT
 compatibility
In-Reply-To: <1424947028-7438-1-git-send-email-geert+renesas@glider.be>
References: <1424947028-7438-1-git-send-email-geert+renesas@glider.be>
Message-ID: <54EF560F.3070805@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2015 03:37 AM, Geert Uytterhoeven wrote:
> When trying to kexec into a new kernel on a platform where multiple CPU
> cores are present, but no SMP bringup code is available yet, the
> kexec_load system call fails with:
>
>      kexec_load failed: Invalid argument
>
> The SMP test added to machine_kexec_prepare() in commit 2103f6cba61a8b8b
> ("ARM: 7807/1: kexec: validate CPU hotplug support") wants to prohibit
> kexec on SMP platforms where it cannot disable secondary CPUs.
> However, this test is too strict: if the secondary CPUs couldn't be
> enabled in the first place, there's no need to disable them later at
> kexec time.  Hence skip the test in the absence of SMP bringup code.
>
> This allows to add all CPU cores to the DTS from the beginning, without
> having to implement SMP bringup first, improving DT compatibility.

Acked-by: Stephen Warren <swarren@nvidia.com>
