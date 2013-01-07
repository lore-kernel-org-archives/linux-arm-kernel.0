From: dianders@chromium.org (Doug Anderson)
Date: Mon, 7 Jan 2013 11:04:16 -0800
Subject: [PATCH] ARM: dts: correct the dw-mshc timing properties as per
 binding
In-Reply-To: <1357557585-30257-1-git-send-email-alim.akhtar@samsung.com>
References: <1357557585-30257-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <CAD=FV=XUpLwZCn=bpShFqiPBzFBaAbWYn5-+-_OuTqC55sKi3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alim,

On Mon, Jan 7, 2013 at 3:19 AM, Alim Akhtar <alim.akhtar@samsung.com> wrote:
> As per the current exynos-dw-mshc bindings, dw-mshc-sdr-timing and
> dw-mshc-ddr-timing properties are having only two cells, these properties
> are wrongly set for exynos5250 based cros5250 and smdk5250 platfroms. This patch
> corrects above timing propreties for above platfroms

Thanks for catching this.  Given that this just removes a number from
the dts file that isn't read by the code, I don't expect any
functional change and I don't see any.

I also double-checked usage and compared to the current Chrome OS
tree.  The third number (that you removed) is already correctly
specified in the dts as "samsung,dw-mshc-ciu-div".  :)


> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Tested-by: Doug Anderson <dianders@chromium.org>
Acked-by: Doug Anderson <dianders@chromium.org>
