From: dianders@chromium.org (Doug Anderson)
Date: Tue, 21 Jun 2016 10:19:58 -0700
Subject: [PATCH v4 3/8] iommu/rockchip: Fix allocation of bases array in
 driver probe
In-Reply-To: <1466483681-36110-4-git-send-email-tfiga@chromium.org>
References: <1466483681-36110-1-git-send-email-tfiga@chromium.org>
 <1466483681-36110-4-git-send-email-tfiga@chromium.org>
Message-ID: <CAD=FV=Vunsf0vEyn-MTmr-+5jy+q81423HVtMsP6cTECyiciXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 20, 2016 at 9:34 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> From: Shunqian Zheng <zhengsq@rock-chips.com>
>
> In .probe(), devm_kzalloc() is called with size == 0 and works only
> by luck, due to internal behavior of the allocator and the fact
> that the proper allocation size is small. Let's use proper value for
> calculating the size.
>
> Fixes: cd6438c5f844 ("iommu/rockchip: Reconstruct to support multi slaves")
>
> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> ---
>  drivers/iommu/rockchip-iommu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
