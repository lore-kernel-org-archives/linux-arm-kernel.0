From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Sun, 3 Sep 2017 18:19:34 +0530
Subject: [PATCH] rtc: remove cast to void pointer
In-Reply-To: <1504017543-19720-1-git-send-email-himanshujha199640@gmail.com>
References: <1504017543-19720-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <20170903124934.GA5972@himanshu-Vostro-3559>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 29, 2017 at 08:09:03PM +0530, Himanshu Jha wrote:
> casting to void pointer from any pointer type and vice-versa is done
> implicitly and therefore casting is not needed in such a case.
>

I hope my patch is in your queue, got no reply till now.

Thanks


> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  drivers/rtc/interface.c      | 4 ++--
>  drivers/rtc/rtc-88pm80x.c    | 2 +-
>  drivers/rtc/rtc-88pm860x.c   | 2 +-
>  drivers/rtc/rtc-at32ap700x.c | 2 +-
>  drivers/rtc/rtc-hym8563.c    | 2 +-
>  drivers/rtc/rtc-m48t59.c     | 2 +-
>  drivers/rtc/rtc-max8925.c    | 2 +-
>  drivers/rtc/rtc-pic32.c      | 2 +-
>  drivers/rtc/rtc-s3c.c        | 4 ++--
>  drivers/rtc/rtc-st-lpc.c     | 2 +-
>  drivers/rtc/rtc-stm32.c      | 2 +-
>  drivers/rtc/rtc-sun6i.c      | 2 +-
>  drivers/rtc/rtc-sunxi.c      | 2 +-
>  drivers/rtc/rtc-vr41xx.c     | 4 ++--
>  drivers/rtc/rtc-xgene.c      | 2 +-
>  drivers/rtc/rtc-zynqmp.c     | 2 +-
>  16 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 8cec9a0..81c85d2 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -528,7 +528,7 @@ void rtc_handle_legacy_irq(struct rtc_device *rtc, int num, int mode)
>   */
>  void rtc_aie_update_irq(void *private)
>  {
> -	struct rtc_device *rtc = (struct rtc_device *)private;
> +	struct rtc_device *rtc = private;
>  	rtc_handle_legacy_irq(rtc, 1, RTC_AF);
>  }
>  
> @@ -541,7 +541,7 @@ void rtc_aie_update_irq(void *private)
>   */
>  void rtc_uie_update_irq(void *private)
>  {
> -	struct rtc_device *rtc = (struct rtc_device *)private;
> +	struct rtc_device *rtc = private;
>  	rtc_handle_legacy_irq(rtc, 1,  RTC_UF);
>  }
>  
> diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
> index 466bf7f..819612e 100644
> --- a/drivers/rtc/rtc-88pm80x.c
> +++ b/drivers/rtc/rtc-88pm80x.c
> @@ -60,7 +60,7 @@ struct pm80x_rtc_info {
>  
>  static irqreturn_t rtc_update_handler(int irq, void *data)
>  {
> -	struct pm80x_rtc_info *info = (struct pm80x_rtc_info *)data;
> +	struct pm80x_rtc_info *info = data;
>  	int mask;
>  
>  	mask = PM800_ALARM | PM800_ALARM_WAKEUP;
> diff --git a/drivers/rtc/rtc-88pm860x.c b/drivers/rtc/rtc-88pm860x.c
> index 19e53b3..67f7fa3 100644
> --- a/drivers/rtc/rtc-88pm860x.c
> +++ b/drivers/rtc/rtc-88pm860x.c
> @@ -59,7 +59,7 @@ struct pm860x_rtc_info {
>  
>  static irqreturn_t rtc_update_handler(int irq, void *data)
>  {
> -	struct pm860x_rtc_info *info = (struct pm860x_rtc_info *)data;
> +	struct pm860x_rtc_info *info = data;
>  	int mask;
>  
>  	mask = ALARM | ALARM_WAKEUP;
> diff --git a/drivers/rtc/rtc-at32ap700x.c b/drivers/rtc/rtc-at32ap700x.c
> index de8bf56..f603f99 100644
> --- a/drivers/rtc/rtc-at32ap700x.c
> +++ b/drivers/rtc/rtc-at32ap700x.c
> @@ -164,7 +164,7 @@ static int at32_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
>  
>  static irqreturn_t at32_rtc_interrupt(int irq, void *dev_id)
>  {
> -	struct rtc_at32ap700x *rtc = (struct rtc_at32ap700x *)dev_id;
> +	struct rtc_at32ap700x *rtc = dev_id;
>  	unsigned long isr = rtc_readl(rtc, ISR);
>  	unsigned long events = 0;
>  	int ret = IRQ_NONE;
> diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
> index e5ad527..0709968 100644
> --- a/drivers/rtc/rtc-hym8563.c
> +++ b/drivers/rtc/rtc-hym8563.c
> @@ -436,7 +436,7 @@ static struct clk *hym8563_clkout_register_clk(struct hym8563 *hym8563)
>   */
>  static irqreturn_t hym8563_irq(int irq, void *dev_id)
>  {
> -	struct hym8563 *hym8563 = (struct hym8563 *)dev_id;
> +	struct hym8563 *hym8563 = dev_id;
>  	struct i2c_client *client = hym8563->client;
>  	struct mutex *lock = &hym8563->rtc->ops_lock;
>  	int data, ret;
> diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
> index d99a705..2e35f73 100644
> --- a/drivers/rtc/rtc-m48t59.c
> +++ b/drivers/rtc/rtc-m48t59.c
> @@ -302,7 +302,7 @@ static int m48t59_rtc_proc(struct device *dev, struct seq_file *seq)
>   */
>  static irqreturn_t m48t59_rtc_interrupt(int irq, void *dev_id)
>  {
> -	struct device *dev = (struct device *)dev_id;
> +	struct device *dev = dev_id;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct m48t59_plat_data *pdata = dev_get_platdata(&pdev->dev);
>  	struct m48t59_private *m48t59 = platform_get_drvdata(pdev);
> diff --git a/drivers/rtc/rtc-max8925.c b/drivers/rtc/rtc-max8925.c
> index 67d6fc2..45d7e40 100644
> --- a/drivers/rtc/rtc-max8925.c
> +++ b/drivers/rtc/rtc-max8925.c
> @@ -74,7 +74,7 @@ struct max8925_rtc_info {
>  
>  static irqreturn_t rtc_update_handler(int irq, void *data)
>  {
> -	struct max8925_rtc_info *info = (struct max8925_rtc_info *)data;
> +	struct max8925_rtc_info *info = data;
>  
>  	/* disable ALARM0 except for 1SEC alarm */
>  	max8925_set_bits(info->rtc, MAX8925_ALARM0_CNTL, 0x7f, 0);
> diff --git a/drivers/rtc/rtc-pic32.c b/drivers/rtc/rtc-pic32.c
> index 5cfb6df..04788c3 100644
> --- a/drivers/rtc/rtc-pic32.c
> +++ b/drivers/rtc/rtc-pic32.c
> @@ -92,7 +92,7 @@ static void pic32_rtc_alarm_clk_enable(struct pic32_rtc_dev *pdata,
>  
>  static irqreturn_t pic32_rtc_alarmirq(int irq, void *id)
>  {
> -	struct pic32_rtc_dev *pdata = (struct pic32_rtc_dev *)id;
> +	struct pic32_rtc_dev *pdata = id;
>  
>  	clk_enable(pdata->clk);
>  	rtc_update_irq(pdata->rtc, 1, RTC_AF | RTC_IRQF);
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index a8992c2..8e8a815 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -113,7 +113,7 @@ static void s3c_rtc_disable_clk(struct s3c_rtc *info)
>  /* IRQ Handlers */
>  static irqreturn_t s3c_rtc_tickirq(int irq, void *id)
>  {
> -	struct s3c_rtc *info = (struct s3c_rtc *)id;
> +	struct s3c_rtc *info = id;
>  
>  	if (info->data->irq_handler)
>  		info->data->irq_handler(info, S3C2410_INTP_TIC);
> @@ -123,7 +123,7 @@ static irqreturn_t s3c_rtc_tickirq(int irq, void *id)
>  
>  static irqreturn_t s3c_rtc_alarmirq(int irq, void *id)
>  {
> -	struct s3c_rtc *info = (struct s3c_rtc *)id;
> +	struct s3c_rtc *info = id;
>  
>  	if (info->data->irq_handler)
>  		info->data->irq_handler(info, S3C2410_INTP_ALM);
> diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
> index 82b0af1..75eb92c 100644
> --- a/drivers/rtc/rtc-st-lpc.c
> +++ b/drivers/rtc/rtc-st-lpc.c
> @@ -74,7 +74,7 @@ static void st_rtc_set_hw_alarm(struct st_rtc *rtc,
>  
>  static irqreturn_t st_rtc_handler(int this_irq, void *data)
>  {
> -	struct st_rtc *rtc = (struct st_rtc *)data;
> +	struct st_rtc *rtc = data;
>  
>  	rtc_update_irq(rtc->rtc_dev, 1, RTC_AF);
>  
> diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
> index 3a5c3d7..66fc7ba 100644
> --- a/drivers/rtc/rtc-stm32.c
> +++ b/drivers/rtc/rtc-stm32.c
> @@ -169,7 +169,7 @@ static int stm32_rtc_wait_sync(struct stm32_rtc *rtc)
>  
>  static irqreturn_t stm32_rtc_alarm_irq(int irq, void *dev_id)
>  {
> -	struct stm32_rtc *rtc = (struct stm32_rtc *)dev_id;
> +	struct stm32_rtc *rtc = dev_id;
>  	unsigned int isr, cr;
>  
>  	mutex_lock(&rtc->rtc_dev->ops_lock);
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index 305c4d0..496a8dd 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -256,7 +256,7 @@ CLK_OF_DECLARE_DRIVER(sun6i_rtc_clk, "allwinner,sun6i-a31-rtc",
>  
>  static irqreturn_t sun6i_rtc_alarmirq(int irq, void *id)
>  {
> -	struct sun6i_rtc_dev *chip = (struct sun6i_rtc_dev *) id;
> +	struct sun6i_rtc_dev *chip = id;
>  	irqreturn_t ret = IRQ_NONE;
>  	u32 val;
>  
> diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
> index abada60..f1f7fd7 100644
> --- a/drivers/rtc/rtc-sunxi.c
> +++ b/drivers/rtc/rtc-sunxi.c
> @@ -158,7 +158,7 @@ struct sunxi_rtc_dev {
>  
>  static irqreturn_t sunxi_rtc_alarmirq(int irq, void *id)
>  {
> -	struct sunxi_rtc_dev *chip = (struct sunxi_rtc_dev *) id;
> +	struct sunxi_rtc_dev *chip = id;
>  	u32 val;
>  
>  	val = readl(chip->base + SUNXI_ALRM_IRQ_STA);
> diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
> index 7ce2296..a0aa377 100644
> --- a/drivers/rtc/rtc-vr41xx.c
> +++ b/drivers/rtc/rtc-vr41xx.c
> @@ -228,7 +228,7 @@ static int vr41xx_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
>  
>  static irqreturn_t elapsedtime_interrupt(int irq, void *dev_id)
>  {
> -	struct platform_device *pdev = (struct platform_device *)dev_id;
> +	struct platform_device *pdev = dev_id;
>  	struct rtc_device *rtc = platform_get_drvdata(pdev);
>  
>  	rtc2_write(RTCINTREG, ELAPSEDTIME_INT);
> @@ -240,7 +240,7 @@ static irqreturn_t elapsedtime_interrupt(int irq, void *dev_id)
>  
>  static irqreturn_t rtclong1_interrupt(int irq, void *dev_id)
>  {
> -	struct platform_device *pdev = (struct platform_device *)dev_id;
> +	struct platform_device *pdev = dev_id;
>  	struct rtc_device *rtc = platform_get_drvdata(pdev);
>  	unsigned long count = periodic_count;
>  
> diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
> index 65b432a..2b8247d 100644
> --- a/drivers/rtc/rtc-xgene.c
> +++ b/drivers/rtc/rtc-xgene.c
> @@ -131,7 +131,7 @@ static const struct rtc_class_ops xgene_rtc_ops = {
>  
>  static irqreturn_t xgene_rtc_interrupt(int irq, void *id)
>  {
> -	struct xgene_rtc_dev *pdata = (struct xgene_rtc_dev *) id;
> +	struct xgene_rtc_dev *pdata = id;
>  
>  	/* Check if interrupt asserted */
>  	if (!(readl(pdata->csr_base + RTC_STAT) & RTC_STAT_BIT))
> diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
> index da18a8a..f2f8a2d 100644
> --- a/drivers/rtc/rtc-zynqmp.c
> +++ b/drivers/rtc/rtc-zynqmp.c
> @@ -193,7 +193,7 @@ static const struct rtc_class_ops xlnx_rtc_ops = {
>  
>  static irqreturn_t xlnx_rtc_interrupt(int irq, void *id)
>  {
> -	struct xlnx_rtc_dev *xrtcdev = (struct xlnx_rtc_dev *)id;
> +	struct xlnx_rtc_dev *xrtcdev = id;
>  	unsigned int status;
>  
>  	status = readl(xrtcdev->reg_base + RTC_INT_STS);
> -- 
> 2.7.4
> 
