From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 16 Apr 2012 16:46:23 +0200
Subject: [PATCH for 3.4] MFD: twl6040: Convert to i2c driver, and
 separate it from twl core
In-Reply-To: <1333443411-23056-1-git-send-email-peter.ujfalusi@ti.com>
References: <1333443411-23056-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120416144623.GD24130@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, Apr 03, 2012 at 11:56:51AM +0300, Peter Ujfalusi wrote:
> Complete the separation of the twl6040 from the twl core since
> it is a separate chip, not part of the twl6030 PMIC.
> 
> Make the needed Kconfig changes for the depending drivers at the same time to
> avoid breaking the kernel build (vibra, ASoC components).
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Mark Brown <broonie@opensource.wolfsonicro.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> Acked-by: Dmitry Torokhov <dtor@mail.ru>
> ---
> 
> Hi Samuel, Tony, Liam,
> 
> Due to some cross tree issues 3.4-rc1 have big regression in OMAP4 audio:
> The twl6040 mfd driver (and codec, vibra) is no longer probe since the twl-core
> now did not create the platform device for it. This means we do not have audio
> working in rc1.
> This patch meant to follow the twl-core change (to not probe the twll6040 as
> platform device), but there were some glitch in the logistics so this patch is
> not in 3.4-rc1.
> 
> I have forward ported it on top of 3.4-rc1, and you can also find the patch in:
> git at gitorious.org:omap-audio/linux-audio.git peter/upstream/for-3.4-rc2
> 
> Can someone take this patch further to be included in 3.4-rc2?
Applied to my for-linus branch. I'll send a pull request this week, so I
expect it to make it to rc4.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
