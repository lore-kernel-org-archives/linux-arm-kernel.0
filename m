From: cjb@laptop.org (Chris Ball)
Date: Sun, 28 Aug 2011 14:11:19 -0400
Subject: [PATCH] mmc: sdhci-s3c: Fix mmc card I/O problem
In-Reply-To: <1314350898-26372-1-git-send-email-girish.shivananjappa@linaro.org>
	(Girish K. S.'s message of "Fri, 26 Aug 2011 14:58:18 +0530")
References: <1314350898-26372-1-git-send-email-girish.shivananjappa@linaro.org>
Message-ID: <m2obz9xv7c.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 26 2011, Girish K S wrote:
> This patch fixes the problem in sdhci-s3c host driver for
> Samsung Soc's. During the card identification stage the
> mmc core driver enumerates for the best bus width in combination
> with the highest available data rate. It starts enumerating from
> the highest bus width (8) to lowest bus width (1).
>
> In case of few MMC cards the 4-bit bus enumeration fails and tries
> the 1-bit bus enumeration. When switched to 1-bit bus mode the host driver
> has to clear the previous bus width setting and apply the new setting.
>
> The current patch will clear the previous bus mode and apply the new
> mode setting.
>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>

Thanks, pushed to mmc-next for 3.1 with a stable@ tag.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
