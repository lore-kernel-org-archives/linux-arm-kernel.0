From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 Jan 2017 18:20:12 +0000
Subject: [BISECT] ARM build errors on GCC v6.2 (crypto: arm/aes - replace
 scalar AES cipher)
In-Reply-To: <20170114142435.ashdj2xm5b3kzg2p@kozik-lap>
References: <20170114142435.ashdj2xm5b3kzg2p@kozik-lap>
Message-ID: <20170114182011.GX14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 14, 2017 at 04:24:35PM +0200, Krzysztof Kozlowski wrote:
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

It's worth pointing out that _assembler_ messages come from _binutils_
rather than _gcc_.   Please advise which version of _binutils_ you
are using.  Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
