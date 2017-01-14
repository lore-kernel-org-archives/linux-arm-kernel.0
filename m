From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 14 Jan 2017 15:21:50 +0000
Subject: [BISECT] ARM build errors on GCC v6.2 (crypto: arm/aes - replace
 scalar AES cipher)
In-Reply-To: <20170114142435.ashdj2xm5b3kzg2p@kozik-lap>
References: <20170114142435.ashdj2xm5b3kzg2p@kozik-lap>
Message-ID: <CAKv+Gu--rj53F9SFRbXLfs5UNa3UC++F2ZqS1AHipVWSF2wJoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 January 2017 at 14:24, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Hi,
>
> allyesconfig and multi_v7_defconfig fail to build on recent linux-next
> on GCC 6.2.0.
>
> Errors:
> ../arch/arm/crypto/aes-cipher-core.S: Assembler messages:
> ../arch/arm/crypto/aes-cipher-core.S:21: Error: selected processor does not support `tt .req ip' in ARM mode
> ../arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `movw tt,#:lower16:crypto_ft_tab'
> ../arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `movt tt,#:upper16:crypto_ft_tab'
>
> Compiler: arm-linux-gnueabi-gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
>
> Git bisect pointed to:
> first bad commit: [81edb42629758bacdf813dd5e4542ae26e3ad73a] crypto: arm/aes - replace scalar AES cipher
>

Fixed in

https://git.kernel.org/cgit/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=658fa754cd07

which should turn up in the next -next
