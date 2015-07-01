From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 1 Jul 2015 10:13:48 +0200
Subject: [PATCH] ARM: mm: handle non-pmd-aligned end of RAM
In-Reply-To: <CABxcv=noPD1vdY5V-G+M16S0y20VO2_s6XbQJG_qM+=dOKtZxg@mail.gmail.com>
References: <a865bd68d706f8c4c9e82a374ff6adc4@agner.ch>
 <20150511103130.GA3490@leverpostej>
 <CABxcv=noPD1vdY5V-G+M16S0y20VO2_s6XbQJG_qM+=dOKtZxg@mail.gmail.com>
Message-ID: <CABxcv=mAEOdnChTCMaOttk1swtRSvuO6XzDY6M8GRg9EL119LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 12:01 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:

[...]

>
> There were reports of 4.1 not booting on the Exynos Chromebooks. I did
> a bisect on an Exynos5420 Peach Pit Chromebook and tracked it down to
> $subject as the cause. Reverting this commit makes it to boot again.
>

I found that the following posted patch by Laura Abbot makes the
system to boot again:

[PATCH] arm: Update memblock limit after mapping lowmem [0].

Best regards,
Javier

[0]: https://lkml.org/lkml/2015/6/4/606
