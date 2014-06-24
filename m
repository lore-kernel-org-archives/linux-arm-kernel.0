From: dianders@google.com (Doug Anderson)
Date: Tue, 24 Jun 2014 09:15:51 -0700
Subject: [PATCH 3/3] ARM: exynos: activate the CCI on boot CPU/cluster
 with the MCPM loopback
In-Reply-To: <1403583071-5650-4-git-send-email-nicolas.pitre@linaro.org>
References: <1403583071-5650-1-git-send-email-nicolas.pitre@linaro.org>
 <1403583071-5650-4-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <CAD=FV=W2KK1XPQiHnxzdBs8fXxsnsuggZg_hJU0zyHcvHt3Khw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas,

On Mon, Jun 23, 2014 at 9:11 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> The Chromebook firmware doesn't enable the CCI for the boot cpu, and
> arguably it shouldn't have to either. Let's have the kernel handle the
> CCI on its own for the boot CPU the same way it does it for secondary CPUs
> by using the MCPM loopback.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/mach-exynos/mcpm-exynos.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Thank you very much for posting!  With your series I'm able to boot
all 8 cores on exynos5420-peach-pit and exynos5800-peach-pi sitting on
my desk.

Tested-by: Doug Anderson <dianders@chromium.org>
