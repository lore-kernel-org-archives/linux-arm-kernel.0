From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 23 Jul 2015 09:38:21 +0900
Subject: [PATCH] clk: s2mps11: Use kcalloc instead of kzalloc for array
 allocation
In-Reply-To: <1437557693-29433-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437557693-29433-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <55B0377D.10908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.07.2015 18:34, Vaibhav Hiremath wrote:
> This patch cleans up the driver for,
> 
>   - Use devm_kcalloc varient instead of devm_kzalloc for array
>     allocation.
>   - clk_prepare/unprepare, remove "ret" variable as it is not required
>   - use __exit for cleanup function
> 
> As I am referring this driver as a reference for my 88pm800 clk driver,
> applying same changes here as well.
> 
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
> Since I do not have platform to test, it would be helpful if someone
> tests it for me.
> I have build tested it.
> 
>  drivers/clk/clk-s2mps11.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)

Looks good, simplifies the code and fixes the __init/__exit.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
