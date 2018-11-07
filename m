From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Nov 2018 13:17:29 +0100
Subject: [RFC PATCH 02/12] soc: qcom: ipa: DMA helpers
In-Reply-To: <20181107003250.5832-3-elder@linaro.org>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-3-elder@linaro.org>
Message-ID: <CAK8P3a3Hur9Kn=QLrn7XDn-Kpgfta1xTxvuwcBze4n2v7fsULw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>
> This patch includes code implementing the IPA DMA module, which
> defines a structure to represent a DMA allocation for the IPA device.
> It's used throughout the IPA code.
>
> Signed-off-by: Alex Elder <elder@linaro.org>

I looked through all the users of this and couldn't fine one that actually
benefits from it. I'd say better drop this patch entirely and open-code
the contents in the callers. That will help readability since the dma
API is well understood by many people.

Generally speaking, try not to wrap Linux interfaces into driver specific
helper functions.

      Arnd
