From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 23 Aug 2013 22:02:40 +0200
Subject: [PATCH v2 5/5] clk/exynos5420: assign sclk_pixel id to pixel
 clock divider
In-Reply-To: <1377241078-11808-6-git-send-email-rahul.sharma@samsung.com>
References: <1377241078-11808-1-git-send-email-rahul.sharma@samsung.com>
 <1377241078-11808-6-git-send-email-rahul.sharma@samsung.com>
Message-ID: <3550203.JkdqaguvYB@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On Friday 23 of August 2013 12:27:58 Rahul Sharma wrote:
> sclk_pixel is used to represent pixel clock divider on all exynos
> SoCs not as a gate clock. It is queried in driver to pass as the
> parent to hdmi clock while switching between parents. A new ID can
> be asssigned Pixel gate clock which is currently not in use. Pixel
> clock gate is default 'on'.

This doesn't sound like a correct assumption, especially if you recall how 
common clock framework works - it disables any unclaimed clock 
automatically. Also we might want to support gating from power management 
reasons.

IMHO you should simply export the dout_hdmi_pixel clock, keeping the 
original sclk_pixel exported as well.

Best regards,
Tomasz
