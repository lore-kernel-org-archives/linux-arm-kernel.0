From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 18 Mar 2015 22:26:12 +0000
Subject: [PATCH v5 8/8] arm64: enforce x1|x2|x3 == 0 upon kernel entry as
 per boot protocol
In-Reply-To: <20150318185737.GJ19814@leverpostej>
References: <1426690527-14258-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426690527-14258-9-git-send-email-ard.biesheuvel@linaro.org>
 <20150318181315.GH19814@leverpostej>
 <CAKv+Gu_Psdg1PGbW8mydKGGUvyW=F1D125VSTdABLQEOHMaTwQ@mail.gmail.com>
 <CAKv+Gu_f=e4UG1GmtFh7j8fvq67v94VA=FwgaxHV5rECx0Wf=Q@mail.gmail.com>
 <20150318185737.GJ19814@leverpostej>
Message-ID: <CAFEAcA9GVbP62noRpV6rqyy8abcqiK+GQiYBS7DWdH0czYR7LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 March 2015 at 18:57, Mark Rutland <mark.rutland@arm.com> wrote:
> Annoyingly the minimum cache line size seems to be a word (given the
> defnition of CTR.DminLine), which means you need a few dc ivac
> instructions to be architecturally correct.

Section D3.4.1 says "For the purpose of these principles, a
cache entry covers at least 16 bytes and no more than 2KB of
contiguous address space, aligned to its size.", so (depending
on what you think the "for the purpose of these principles"
means) you may be OK there.

-- PMM
