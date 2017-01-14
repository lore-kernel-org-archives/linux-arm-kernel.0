From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 14 Jan 2017 16:24:35 +0200
Subject: [BISECT] ARM build errors on GCC v6.2 (crypto: arm/aes - replace
 scalar AES cipher)
Message-ID: <20170114142435.ashdj2xm5b3kzg2p@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

allyesconfig and multi_v7_defconfig fail to build on recent linux-next
on GCC 6.2.0.

Errors:
../arch/arm/crypto/aes-cipher-core.S: Assembler messages:
../arch/arm/crypto/aes-cipher-core.S:21: Error: selected processor does not support `tt .req ip' in ARM mode
../arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `movw tt,#:lower16:crypto_ft_tab'
../arch/arm/crypto/aes-cipher-core.S:174: Error: ARM register expected -- `movt tt,#:upper16:crypto_ft_tab'

Compiler: arm-linux-gnueabi-gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005

Git bisect pointed to:
first bad commit: [81edb42629758bacdf813dd5e4542ae26e3ad73a] crypto: arm/aes - replace scalar AES cipher

Best regards,
Krzysztof
