From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 10 May 2013 02:24:38 +0200
Subject: [PATCH V2 0/3] clk: Samsung: audss: Register audio subsytem
 clocks using common clk framework
In-Reply-To: <1367909016-19657-1-git-send-email-padma.v@samsung.com>
References: <1367909016-19657-1-git-send-email-padma.v@samsung.com>
Message-ID: <1561518.UR9S1ZDj1n@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Padmavathi,

On Tuesday 07 of May 2013 12:13:33 Padmavathi Venna wrote:
> Samsung S5PV210 and Exynos SoC has a separate subsystem for audio. This
> subsystem has a internal clock controller which controls i2s0 and pcm0
> clocks. This patch series adds the Samsung audio subsytem clock to the
> common clock framework and provides the I2S controllers clock
> information in the dtsi file.
> 
> This patch series is dependent on
> https://patchwork.kernel.org/patch/2532091/
> http://www.spinics.net/lists/linux-kbuild/msg07616.html
> 
> This patch series is made based on Kukjin Kim for-next branch
> 
> Changes since V1:
> 	- Reworked on all review comments by Sylwester Nawrocki
> 	- Added a header file for all clock indexes as requested by 
Sylwester
> 	- Added different compatible names for s5pv210, exynos4 and 
exynos5
> 	- Registered the pcm clocks with common clock framework
> 
> Padmavathi Venna (3):
>   clk: samsung: register audio subsystem clocks using common clock
>     framework
>   ARM: dts: add Exynos audio subsystem clock controller node
>   ARM: dts: add clock provider information for i2s controllers in
>     Exynos5250
> 
>  .../bindings/clock/clk-samsung-audss.txt           |   64 +++++++++
>  arch/arm/boot/dts/exynos5250.dtsi                  |   16 +++
>  drivers/clk/samsung/Makefile                       |    1 +
>  drivers/clk/samsung/clk-samsung-audss.c            |  137
> ++++++++++++++++++++ include/dt-bindings/clk/samsung-audss-clk.h       
> |   25 ++++ 5 files changed, 243 insertions(+), 0 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/clock/clk-samsung-audss.txt create
> mode 100644 drivers/clk/samsung/clk-samsung-audss.c
>  create mode 100644 include/dt-bindings/clk/samsung-audss-clk.h

Also, I think that this series lacks

Cc: Mike Turquette <mturquette@linaro.org>

as he's the maintainer of the clk subsystem.

Best regards,
Tomasz
