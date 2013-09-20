From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 20 Sep 2013 15:12:10 -0400 (EDT)
Subject: [PATCH 0/4] ARM: NEON based fast(er) AES in CBC/CTR/XTS modes
In-Reply-To: <1379702811-8025-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1379702811-8025-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.03.1309201501010.312@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Sep 2013, Ard Biesheuvel wrote:

> Note to reviewers:
> Reviewing the file aesbs-core.S may be a bit overwhelming, so if there are any
> questions or concerns, please refer to the link below. This is the original Perl
> script that gets called by OpenSSL's build system during their build to generate
> the .S file on the fly. [In the case of OpenSSL, this is used in some cases to
> target different assemblers or ABIs]. This arrangement is not suitable (or 
> required) for the kernel, so I have taken the generated .S file instead.
> 
> http://git.openssl.org/gitweb/?p=openssl.git;f=crypto/aes/asm/bsaes-armv7.pl;a=blob

You should probably capture this reference in the code, or at least in 
the commit log for the corresponding patch.

> Note to integrators:
> While this implementation is significantly faster, especially in CTR mode, it is
> unclear whether the net impact on power efficiency is favorable or not, so
> please refrain from making any assumptions to that effect.

That definitively should be mentioned in the commit log for patch #4.


Nicolas
