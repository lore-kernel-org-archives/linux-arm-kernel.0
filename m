From: cjb@laptop.org (Chris Ball)
Date: Thu, 10 Nov 2011 15:09:54 -0500
Subject: [PATCH 2/3] mmc: sdhci-pxa: Add SDHCI driver for PXA16x
In-Reply-To: <1319546229-31804-1-git-send-email-tanmay.upadhyay@einfochips.com>
 (Tanmay Upadhyay's message of "Tue, 25 Oct 2011 18:07:09 +0530")
References: <1319546229-31804-1-git-send-email-tanmay.upadhyay@einfochips.com>
Message-ID: <87r51fwxgt.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tanmay and Philip,

On Tue, Oct 25 2011, Tanmay Upadhyay wrote:
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
> ---
>  drivers/mmc/host/Kconfig                |   13 ++
>  drivers/mmc/host/Makefile               |    1 +
>  drivers/mmc/host/sdhci-pxav1.c          |  256 +++++++++++++++++++++++++++++++

By my script's count, 215 of the 256 lines in this file (84%) are simply
duplicated from sdhci-pxav2.c, which makes me think we've failed at
abstraction here.  Can you have a think about how to do better, please?

My intuition is that since there are only 41 lines of difference (actually,
less, since the only difference on many of these is s/pxav2/pxav1/g), I'd
rather see this become special-cases in the sdhci-pxav2.c code.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
