From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 24 Nov 2015 10:23:41 +0100
Subject: [PATCH 1/2] mmc: sdhci: set bus voltage before enabling bus power
In-Reply-To: <20151109163026.GE15706@odux.rfo.atmel.com>
References: <1446825570-30029-1-git-send-email-ludovic.desroches@atmel.com>
 <1446825570-30029-2-git-send-email-ludovic.desroches@atmel.com>
 <20151109132305.GC15706@odux.rfo.atmel.com>
 <CAPDyKFrTTEnSFNvmx3e__Ap9gOGpA2-bz+yrq7ibz0wXGSWCXA@mail.gmail.com>
 <20151109144030.GD15706@odux.rfo.atmel.com>
 <CAPDyKFquZ+_Rf07gX+i-=_bzSa7KJ5+xQ8N21kK2mvfMGdVQMw@mail.gmail.com>
 <20151109163026.GE15706@odux.rfo.atmel.com>
Message-ID: <20151124092341.GA2228@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Mon, Nov 09, 2015 at 05:30:26PM +0100, Ludovic Desroches wrote:
> On Mon, Nov 09, 2015 at 05:00:46PM +0100, Ulf Hansson wrote:

[...]

> > Now, this discussion was interesting, but I forgot what problem you
> > actually where trying to solve? :-)
> 
> There is this discussion because of two things:
> - Fixing something I consider as a bug: when I have a VMMC, only
>   setting/clearing bit 0. Our controller strictly obeys to the spec and
>   check the 'SD Bus Voltage Select' field. Since we put a reserved value
>   (000), the Power On is not performed.
> - I was trying to get help to understand what is this 'SD Bus Voltage'.
>   For our controller and sdhci_set_power(), it seems to stand for VMMC.
>   For me, everything concerning bus voltage is related to VQMMC, so I was
>   disappointed.

Do you plan to take the patch for VMMC? If yes, I will send a new patch
for the device tree (I'll only add vmmc, not vqmmc as discussed); if
not, forget these two patches.

Regards

Ludovic
