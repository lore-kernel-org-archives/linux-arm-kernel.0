From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 3 Feb 2015 09:45:19 -0800
Subject: [PATCH v2] hwmon: tmp102: add hibernation callbacks
In-Reply-To: <1422975718-871-1-git-send-email-grygorii.strashko@linaro.org>
References: <1422975718-871-1-git-send-email-grygorii.strashko@linaro.org>
Message-ID: <20150203174519.GA31926@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 05:01:58PM +0200, grygorii.strashko at linaro.org wrote:
> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> 
> Setting a dev_pm_ops suspend/resume pair but not a set of
> hibernation functions means those pm functions will not be
> called upon hibernation.
> Fix this by using SIMPLE_DEV_PM_OPS, which appropriately
> assigns the suspend and hibernation handlers and move
> mp102_suspend/tmp102_resume under CONFIG_PM_SLEEP to avoid
> build warnings.
> 
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Applied to -next.

Thanks,
Guenter
