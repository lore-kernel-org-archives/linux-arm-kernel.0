From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 15 Apr 2013 15:39:22 +0100
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <516C0E2A.40809@linaro.org>
References: <51680AF9.7040109@arm.com>
 <CAEDV+g+E8PLc60vMRhq4O_AL2WjmYDLb6=Wh34ynhevh7uAGJA@mail.gmail.com>
 <d455f2823b9639af8d38d30f2c3234bd@localhost>
 <CAEDV+gJuFG49oQ=BEaCHcTP=nHVyX8ALw6076dR_C1s7TuyqXQ@mail.gmail.com>
 <d47697abd39a0d5d41f5ac110a40e261@localhost>
 <CAEDV+gK9==sXYxRVZ8JVFYPiw3_xgzZBbydEwPunmnocNLKXrQ@mail.gmail.com>
 <CAFEAcA-bPoa8YoPuHPmupzfUW+yR233XquK79eNorzcRpFiK=g@mail.gmail.com>
 <516BCAD0.9000708@linaro.org>
 <CAJRNFKJoBzgt4UhxsH65_LyhcGXPnzB_pg3q-zeYT2OVv59q4A@mail.gmail.com>
 <516BFD13.1000400@linaro.org>
 <20130415134837.GI9827@mudshark.cambridge.arm.com>
 <516C0E2A.40809@linaro.org>
Message-ID: <CAFEAcA-CwKBnkoGZpO0XmqqKn60bmPvR_tZXM2S3PRv5Rspc2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 April 2013 15:26, Andre Przywara <andre.przywara@linaro.org> wrote:
> But meanwhile I compared the A7 and A15 TRM 4.3.32 HSCTLR:
> Bit 21 is fixed 0 on A15, but fixed 1 on A7.
> Can someone confirm that this is not a typo?

The A7 TRM diagram says '1' but the text says RAZ/WI.
The bit should match SCTLR.FI (bit 21), which the A7 TRM
definitely says is RAZ/WI. If you have the hardware you
can confirm the behaviour yourself by reading the register
and seeing what the bit value is :-)

-- PMM
