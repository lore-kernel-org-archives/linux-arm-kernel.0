From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Fri, 07 Feb 2014 11:19:43 +0100
Subject: [PATCH v3 0/4] ARM: add omap3 INCOstartec board support
In-Reply-To: <1390782797-24105-1-git-send-email-chf.fritz@googlemail.com>
References: <1390782797-24105-1-git-send-email-chf.fritz@googlemail.com>
Message-ID: <1391768383.4937.112.camel@mars>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-01-27 at 01:33 +0100, Christoph Fritz wrote:
> This set of patches adds board support for an omap3 system from INCOstartec.
> It's based on next-20140124.
> 
> Due to a regression since next-20140115 the following errors are present:
> 
>  - pin sys_clkout2, which gets configured to 24 Mhz by the fourth patch
>    in this set, erroneously outputs only 12 Mhz.
>    Just out of curiosity, configuring it to 48 Mhz puts out desired 24 Mhz.
> 
>  - omap_dss, which gets configured by the third patch in this set, fails
>    to do 'dss_set_fck_rate(fck);' in
>    drivers/video/omap2/dss/dss.c:dss_setup_default_clock() which leads to:
> 
>     | omapdss_dss: probe of omapdss_dss failed with error -22
>     | omapdss CORE error: Failed to initialize DSS platform driver
>     | panel-dpi panel-dpi.0: failed to find video source 'dpi.0
> 
>   Both regressions seem to have something to do with the clock framework. 
>   Could this be related to the DT clock conversion patches?

Now with dt clock conversion fixes on its way, any chance to get this
upstream?
