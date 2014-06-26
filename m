From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 26 Jun 2014 09:37:40 +0200
Subject: [PATCH] clk: define and export __clk_get_debug for providers
In-Reply-To: <20140625182349.32686.25931@quantum>
References: <1403713591-17179-1-git-send-email-pdeschrijver@nvidia.com>
 <44039675.8s16pHQIVH@wuerfel> <20140625182349.32686.25931@quantum>
Message-ID: <CAAObsKDVrXRgO1e2=SorGiNUMhGPCCUUPtsjDfnST9gFN4=qTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 June 2014 20:23, Mike Turquette <mturquette@linaro.org> wrote:
>
> Peter,
>
> Just FYI, I'm trying to reverse the trend of prepending double
> underscores for functions that are used by clock providers. That stuff
> started out small and sort of grew out of control ;-)

I'm looking at rebasing Rabin's patches for per-user clks, and I have
had to add a few variants for providers, so they can be called with
clk_core instead. Have been prepending underscores for those internal
variants, but in some cases I had to also append a _internal suffix
because there were already variants without locking.

What convention were you thinking of for distinguishing provider-only
variants for e.g. clk_set_rate?

Regards,

Tomeu
