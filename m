From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 5 Dec 2013 09:49:27 +0000
Subject: Boot time errors/warnings on snowball
In-Reply-To: <20131204185947.GC29268@sirena.org.uk>
References: <CAOesGMgwyU-fJWkiF+78US+vVZ7Ensku-j+O1UPFVt43WDfUsA@mail.gmail.com>
 <CACRpkda3V4bK3_QO76=++Gcm3pJp78G2L3pgAdaJb2NDcAJG6Q@mail.gmail.com>
 <20131204172626.GB26581@lee--X1>
 <CAOesGMjMWqPtJXh7-VAhyA1a95h7mKV8_UZhyTtxgEbUhU8_5Q@mail.gmail.com>
 <20131204175119.GD26581@lee--X1>
 <CAOesGMh7+r9vUvtH_pwJeMyQJGo3u-uJRJ8-OBidzzO1pC5RDA@mail.gmail.com>
 <20131204185947.GC29268@sirena.org.uk>
Message-ID: <20131205094927.GJ26581@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If there's a topic branch for the ARM side I can pull it into ASoC to
> get the window down to a few commits (or even rebase the ux500 stuff
> onto it to remove it).  Or I can sign the ux500 branch for arm-soc.

Mark, don't trouble yourself with this.

As far as I'm aware there shouldn't be any dependency or ordering
issues here. I planned on the transition from platform data to DT to
be fully seamless. We should be using the platform data up until we
remove the AUXDATA, but the driver (or the dmaengine) is attempting to
pull in DMA configuration from the Device Tree, which isn't populated
fully yet.

There is something going on here that I am missing and I'd very much
like to get to the bottom of it before merging upstream.

Please remove the asoc/topic/ux500 altogether and I will resubmit in
its entirety once I've solved all of the issues.

Linus/Olof, the arch/arm stuff is still fine to be merged.

Sorry for any issues this has caused, I'll get to the bottom of it.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
