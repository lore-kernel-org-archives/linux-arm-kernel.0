From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Jan 2012 11:59:59 +0000
Subject: [RFC][PATCH 1/4] lcd: platform-lcd: Eliminate need for platform
 data
In-Reply-To: <1325483675-21908-2-git-send-email-thomas.abraham@linaro.org>
References: <1325483675-21908-1-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120102115959.GG2899@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2012 at 11:24:32AM +0530, Thomas Abraham wrote:

> @@ -10,12 +10,3 @@
>   * published by the Free Software Foundation.
>   *
>  */
> -
> -struct plat_lcd_data;
> -struct fb_info;
> -
> -struct plat_lcd_data {
> -	void	(*set_power)(struct plat_lcd_data *, unsigned int power);
> -	int	(*match_fb)(struct plat_lcd_data *, struct fb_info *);
> -};

This is going to break all existing users as it will stop them compiling
- they'd either need to be converted en masse to the new style as part
of the commit doing this or the driver would need to support both
platform data and new style configuration simultaneously.
