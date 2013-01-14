From: cjb@laptop.org (Chris Ball)
Date: Mon, 14 Jan 2013 14:05:14 -0500
Subject: [PATCH] mmc: sdhci: query card presence from cd-gpio before
 asking SDHCI
In-Reply-To: <1355210622-9753-1-git-send-email-shawn.guo@linaro.org> (Shawn
 Guo's message of "Tue, 11 Dec 2012 15:23:42 +0800")
References: <1355210622-9753-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <87y5fvtwk5.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, Dec 11 2012, Shawn Guo wrote:
> Call mmc_gpio_get_cd() to query card presence from cd-gpio before
> asking SDHCI.  The rationale behind this change is that flag
> SDHCI_QUIRK_BROKEN_CARD_DETECTION is designed for SDHCI controller to
> tell that SDHCI_PRESENT_STATE is broken, and it should be used for this
> case only.  So when cd-gpio is being used, the controller should set
> the flag to tell that SDHCI_PRESENT_STATE is not available.
>
> However, the existing code will skip checking cd-gpio as long as flag
> SDHCI_QUIRK_BROKEN_CARD_DETECTION is set.  Change the querying order
> between cd-gpio and SDHCI to support the rationale above.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks, pushed to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
