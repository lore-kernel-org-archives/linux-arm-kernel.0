From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 18 Aug 2015 16:02:37 +0900
Subject: [PATCHi v2] ARM: dts: Fix bootup issue on smdk5250
In-Reply-To: <1439879360-21150-1-git-send-email-pankaj.dubey@samsung.com>
References: <1439879360-21150-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <55D2D88D.6090200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.08.2015 15:29, Pankaj Dubey wrote:
> From: Yadwinder Singh Brar <yadi.brar01@gmail.com>
> 
> With default config on smdk5250 latest tree throws below message :
> 
> [    2.226049] thermal thermal_zone0: critical temperature reached(224 C),shutting down
> [    2.227840] reboot: Failed to start orderly shutdown: forcing the issue
> 
> and hangs randomly because it reads wrong temperature value.
> 
> I can't figure out any direct relation between LDO10 and TMU from board
> schematics which I have. So making LDO10 always-on to fix issue for now.
> 
> Signed-off-by: Yadwinder Singh Brar <yadi.brar01@gmail.com>
> [pankaj.dubey: resubmitted after rebasing to latest kgene tree]
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
> Resending this patch after rebasing. Previous discussion can be found here [1]
> 
> 
> [1]: http://www.spinics.net/lists/linux-samsung-soc/msg39100.html
> 
> Changes since v1:
>  - Rebased on latest kgene tree, test booting and s2r on SMDK5250 board.
>  - Removed Yadwinder Singh's Samsung's email id as it's no more valid.
>  - Added my Signed-off-by for touching this file and patch.
> 
>  arch/arm/boot/dts/exynos5250-smdk5250.dts | 1 +
>  1 file changed, 1 insertion(+)

Since previous discussion ([1] above) there have not been any updates on
cause of this issue so I think this should go in:

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
