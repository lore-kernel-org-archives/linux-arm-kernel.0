From: zlim.lnx@gmail.com (Z Lim)
Date: Thu, 12 Nov 2015 19:21:13 -0800
Subject: [PATCH 1/2] arm64: bpf: fix JIT frame pointer setup
In-Reply-To: <1447365421-1309-2-git-send-email-yang.shi@linaro.org>
References: <1447365421-1309-1-git-send-email-yang.shi@linaro.org>
 <1447365421-1309-2-git-send-email-yang.shi@linaro.org>
Message-ID: <CABg9mctFoXuttJkGaqOBWm-beDKzui_Fwhj4u+iBBWPXAFsYwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 1:57 PM, Yang Shi <yang.shi@linaro.org> wrote:
> BPF fp should point to the top of the BPF prog stack. The original
> implementation made it point to the bottom incorrectly.
> Move A64_SP to fp before reserve BPF prog stack space.
>
> CC: Zi Shen Lim <zlim.lnx@gmail.com>
> CC: Xi Wang <xi.wang@gmail.com>
> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> ---

Reviewed-by: Zi Shen Lim <zlim.lnx@gmail.com>

Also,

Fixes: e54bcde3d69d ("arm64: eBPF JIT compiler")
Cc: <stable@vger.kernel.org> # 3.18+
