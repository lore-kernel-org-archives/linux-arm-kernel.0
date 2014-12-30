From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 30 Dec 2014 15:39:48 +0300
Subject: [PATCH v5 2/6] ASoC: dwc: Prepare clock before use
In-Reply-To: <faa0193d388fe808c2fae461954bb1730ba29244.1419936132.git.Andrew.Jackson@arm.com>
References: <cover.1419936132.git.Andrew.Jackson@arm.com>
 <faa0193d388fe808c2fae461954bb1730ba29244.1419936132.git.Andrew.Jackson@arm.com>
Message-ID: <54A29D14.6000705@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/30/2014 1:55 PM, Andrew Jackson wrote:

> From: Andrew Jackson <Andrew.Jackson@arm.com>

> Some I2S clocks may require some time to get the clock ready
> for operation and so need to be prepared before they are enabled.
> So, prepare the clock as well as enabling it, but combine the
> two through clk_prepare_enable.

> Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
> ---
>   sound/soc/dwc/designware_i2s.c |    7 +++++--
>   1 files changed, 5 insertions(+), 2 deletions(-)

> diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
> index 5e9d163..08608c1 100644
> --- a/sound/soc/dwc/designware_i2s.c
> +++ b/sound/soc/dwc/designware_i2s.c
[...]
> @@ -426,13 +426,16 @@ static int dw_i2s_probe(struct platform_device *pdev)
[...]
>   static int dw_i2s_remove(struct platform_device *pdev)
>   {
> +	struct dw_i2s_dev *dev = dev_get_drvdata(&pdev->dev);

    Why not just platform_get_drvdata(pdev)?

[...]

WBR, Sergei
