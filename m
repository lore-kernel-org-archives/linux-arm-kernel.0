From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 13 Mar 2013 10:21:16 +0800
Subject: [PATCH v4 0/2] Uncompress debug for multiplatform
In-Reply-To: <513F72A4.8020309@wwwdotorg.org>
References: <1363001737-8745-1-git-send-email-shawn.guo@linaro.org>
 <20130311170350.GM4977@n2100.arm.linux.org.uk>
 <513E149A.2060704@wwwdotorg.org>
 <20130312040242.GF25910@S2101-09.ap.freescale.net>
 <513F72A4.8020309@wwwdotorg.org>
Message-ID: <20130313022115.GE27461@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 12:23:32PM -0600, Stephen Warren wrote:
> > Yeah, that's why I did not touch Tegra as the series is based on
> > v3.9-rc1 where Tegra hasn't been part of multi-platform yet.
> > 
> > But I just noticed that debug-macro.S for Tegra has been renamed to
> > debug/tegra.S, and we already know it will be broken when multi-platform
> > is enabled together with this series for Tegra.
> 
> Was that because the code touches .data? Perhaps I can get away with
> using some hard-coded IRAM location or something.

Even worse.  It has the reference to tegra_uart_config which will be
unavailable in decompressor.

Shawn
