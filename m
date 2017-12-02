From: peterz@infradead.org (Peter Zijlstra)
Date: Sat, 2 Dec 2017 10:01:07 +0100
Subject: [PATCH 0/5] crypto: arm64 - disable NEON across scatterwalk API
 calls
In-Reply-To: <20171201211927.24653-1-ard.biesheuvel@linaro.org>
References: <20171201211927.24653-1-ard.biesheuvel@linaro.org>
Message-ID: <20171202090107.GT3326@worktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 09:19:22PM +0000, Ard Biesheuvel wrote:
> Note that the remaining crypto drivers simply operate on fixed buffers, so
> while the RT crowd may still feel the need to disable those (and the ones
> below as well, perhaps), they don't call back into the crypto layer like
> the ones updated by this series, and so there's no room for improvement
> there AFAICT.

Do these other drivers process all the blocks fed to them in one go
under a single NEON section, or do they do a single fixed block per
NEON invocation?
