From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 8 Nov 2013 16:04:51 +0800
Subject: [RFC PATCH 1/3] ARM: imx: cpuidle: Convert imx5 driver to
 platform driver
In-Reply-To: <527B505E.9080409@linaro.org>
References: <1382978973-4034-1-git-send-email-daniel.lezcano@linaro.org>
 <20131107075607.GA6500@S2101-09.ap.freescale.net>
 <527B505E.9080409@linaro.org>
Message-ID: <20131108080448.GA8790@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 09:33:34AM +0100, Daniel Lezcano wrote:
> On 11/07/2013 08:56 AM, Shawn Guo wrote:
> >On Mon, Oct 28, 2013 at 09:49:31AM -0700, Daniel Lezcano wrote:
> >>@@ -149,6 +149,13 @@ static void imx5_pm_idle(void)
> >>  	imx5_cpu_do_idle();
> >>  }
> >>
> >>+static struct platform_device imx5_cpuidle_pdev = {
> >>+	.name = "cpuidle-imx5",
> >>+	.dev = {
> >>+		.platform_data = imx5_pm_idle,
> >
> >This is a little bit hackish and less future proof.  We should probably
> >create a data structure with the function hook as a field in it.
> 
> Yeah, I agree that is what I was planning for the near future as
> soon as the driver is moved into the drivers/cpuidle directory. As
> the other drivers are following the same scheme I want to define a
> common ops structure to be shared across the different driver. But I
> need to have several drivers in the same place in order to define
> the different idle callback.
> 
> Is it acceptable we keep this for the moment as the other cpuidle
> driver like cpuidle-at91 and then consolidate with a structure with
> an additional patchset addressing several drivers at once ?

Okay.

Shawn
