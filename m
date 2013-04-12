From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Apr 2013 11:30:00 +0800
Subject: [PATCH v2] video: mxsfb: Adapt to new videomode API
In-Reply-To: <1365736166-9840-1-git-send-email-festevam@gmail.com>
References: <1365736166-9840-1-git-send-email-festevam@gmail.com>
Message-ID: <20130412032958.GG16970@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 12:09:26AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> commit 6cd2c7db4 (videomode: videomode_from_timing work) changed the name of 
> the function from videomode_from_timing() to videomode_from_timings().
> 
> commit 32ed6ef1 (videomode: create enum for videomode's display flags) changed
> the 'data_flags' field in videomode structure to 'flags'
> 
> Adapt to these changes in order to fix the following errors:
> 
> drivers/video/mxsfb.c:761:3: error: too many arguments to function 'videomode_from_timing'
> drivers/video/mxsfb.c:761:7: error: void value not ignored as it ought to be
> drivers/video/mxsfb.c:768:9: error: 'struct videomode' has no member named 'data_flags'
> drivers/video/mxsfb.c:770:9: error: 'struct videomode' has no member named 'data_flags'
> 
> Also, select VIDEOMODE_HELPER instead of OF_VIDEOMODE, as this one is 
> deprecated.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Queued for 3.10-rc, thanks.
