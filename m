From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 24 Jun 2013 11:10:14 +0200
Subject: [PATCH 0/5] Kernel mode NEON for XOR and RAID6
In-Reply-To: <20130624085427.GY2718@n2100.arm.linux.org.uk>
References: <1370530985-20619-1-git-send-email-ard.biesheuvel@linaro.org>
 <20130606151705.GG16794@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1306061156330.18597@syhkavp.arg>
 <20130607175007.GH8111@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1306072214120.18597@syhkavp.arg>
 <20130621093311.GD6983@mudshark.cambridge.arm.com>
 <CAKv+Gu8FTXC9XSE4DJ2LQueJ3FKjdjv8=sjDjTETH7fq+ruNGQ@mail.gmail.com>
 <51C46A0D.8070505@codeaurora.org>
 <CAKv+Gu-jeHfJ1Ai63NVwY=x4PTfg+w_SnhzF4Sxs2+Xk+PpsoQ@mail.gmail.com>
 <20130624085427.GY2718@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu_T+H6A_huQxqJkKW=gXuhSKQrrE50FN7wF8_LkWQdu_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 June 2013 10:54, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>
> I think it's probably fine now - you have ample justification, and you
> seem to be ensuring that things are done safely.
>

Great!

> The only thing I'm left wondering about is whether the bits outside
> arch/arm should go to anyone else, but MAINTAINERS is being unhelpful
> on that - so I'm tempted to say that if someone should've been copied
> who hasn't, and they're not in MAINTAINERS that's their problem.

As far as the RAID6 patch is concerned, my plan was to:
- get the ARM groundwork (this series) accepted (including the XOR
patch, which does live strictly under arch/arm);
- get the arm64 groundwork accepted (which uses the same API);
- post the RAID6 patch to LKML and cc to hpa (I have a local version
which has been slightly tweaked so it builds correctly for both arm
and arm64).

However, the RAID 6 patch does only affect arm/arm64, so perhaps it's
justified that you take it all in, only in that case, please allow me
to re-send the pull request so it contains the version that will build
on arm64 as well.

Regards,
Ard.
