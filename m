From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Mar 2012 20:15:51 -0600
Subject: [PATCH v4 04/10] ARM: tegra: Fix PWM clock programming
In-Reply-To: <1331740593-10807-5-git-send-email-thierry.reding@avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-5-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4F67E857.9050402@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2012 09:56 AM, Thierry Reding wrote:
> From: Simon Que <sque@chromium.org>
> 
> PWM clock source registers in Tegra 2 have different clock source selection bit
> fields than other registers.  PWM clock source bits in CLK_SOURCE_PWM_0 register
> are located at bit field bit[30:28] while others are at bit field bit[31:30] in
> their respective clock source register.
> 
> This patch updates the clock programming to correctly reflect that, by adding a
> flag to indicate the alternate bit field format and checking for it when
> selecting a clock source (parent clock).
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> Signed-off-by: Bill Huang <bilhuang@nvidia.com>
> Signed-off-by: Simon Que <sque@chromium.org>

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
