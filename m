From: zonque@gmail.com (Daniel Mack)
Date: Wed, 03 Oct 2012 00:28:45 +0200
Subject: [alsa-devel] [PATCH 0/3] ASoC: Davinci: McASP: add support new
 McASP IP Variant
In-Reply-To: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <506B6A9D.3090100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.08.2012 14:50, Hebbar, Gururaja wrote:
> The OMAP2+ variant of McASP is different from Davinci variant w.r.to some
> register offset and missing generic SRAM APIs support
> 
> Changes
> - Add new MCASP_VERSION_3 to identify new variant. New DT compatible
>   "ti,omap2-mcasp-audio" to identify version 3 controller.
> - The register offsets are handled depending on the version.
> - Provide a config option to indicate missing SRAM API support.

Could you give some insight which hardware this was tested on? I'm
trying to get this up and running on a AM33xx board, and the patches
look all reasonable to me. My problem is that I can't make the DMA
engine move forward, I fail to receive a single interrupt on this
peripheral after the stream starts. I will continue searching for the
reason of this tomorrow, but maybe you can give me some hint by
explaining your setup?

Note that I'm using your patches together with Matt's from this series:

  https://github.com/ohporter/linux/tree/edma-dmaengine-am33xx-rfc-v1

... but it doesn't work without those either.



Thanks,
Daniel
