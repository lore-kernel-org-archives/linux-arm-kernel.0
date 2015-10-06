From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 6 Oct 2015 09:57:50 +0800
Subject: [PATCH] soc: mediatek: Fix random hang up issue while kernel init
In-Reply-To: <1443162717-64831-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1443162717-64831-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <CAGS+omD0FSefd9vF0iUvFRXK1+m7YPEANpxngTibGwgR_rTNvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 2:31 PM, James Liao <jamesjj.liao@mediatek.com> wrote:
> In kernel late init, it turns off all unused clocks, which
> needs to access subsystem registers such as VENC and VENC_LT.
>
> Accessing MT8173 VENC registers needs two top clocks, mm_sel and
> venc_sel. Accessing VENC_LT registers needs mm_sel and venclt_sel.
> So we need to keep these clocks on before accessing their registers.
>
> This patch keeps venc_sel / venclt_sel clock on when
> VENC / VENC_LT's power is on, to prevent system hang up while
> accessing its registeres.
>
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>

After the discussions with James here on the list, I'm happy with this fix.
Compared to any proposed alternative, this patch seems just as
effective and is also simpler and more maintainable and extensible (if
other clocks/power domains need the same treatment).

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
