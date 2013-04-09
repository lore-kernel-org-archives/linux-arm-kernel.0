From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 9 Apr 2013 11:04:35 +0100
Subject: [PATCH 4/5] dmaengine: ste_dma40: Do not configure channels
 during an channel allocation
In-Reply-To: <201304091136.09629.arnd@arndb.de>
References: <1365434591-21569-1-git-send-email-lee.jones@linaro.org>
 <1365434591-21569-4-git-send-email-lee.jones@linaro.org>
 <20130409071154.GH3084@gmail.com>
 <201304091136.09629.arnd@arndb.de>
Message-ID: <20130409100435.GB25316@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 09 Apr 2013, Arnd Bergmann wrote:

> On Tuesday 09 April 2013, Lee Jones wrote:
> > According to the DMA documentation allocating a channel and configuring
> > it are two separate actions. By removing the configuration code from the
> > channel allocation path we lighten the burden on the information required to
> > successfully allocate a channel.
> 
> Did you send out the first version again? The text is the same as before.

No, the first commit message implied I'd moved the config code from
'allocate' to 'configure', whereas in reality I just removed it from
'allocate', as it's already in 'configure'.

This changelog is different (and more accurate) than the first.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
