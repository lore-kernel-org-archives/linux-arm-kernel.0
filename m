From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Sep 2013 09:08:14 +0200
Subject: [PATCH 4/4] ARM: add support for bit sliced AES using NEON
 instructions
In-Reply-To: <523ED087.7050006@iki.fi>
References: <1379702811-8025-1-git-send-email-ard.biesheuvel@linaro.org>
 <1379702811-8025-5-git-send-email-ard.biesheuvel@linaro.org>
 <523ED087.7050006@iki.fi>
Message-ID: <CAKv+Gu8us1RRGKzg_91EAxAWJ9oA=StfPfBWqahKAiDjpUjsVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 September 2013 13:12, Jussi Kivilinna <jussi.kivilinna@iki.fi> wrote:

[...]

> Decryption can probably be made faster by implementing InvMixColumns slightly
> differently. Instead of implementing inverse MixColumns matrix directly, use
> preprocessing step, followed by MixColumns as described in section "4.1.3
> Decryption" of "The Design of Rijndael: AES - The Advanced Encryption Standard"
> (J. Daemen, V. Rijmen / 2002).
>
> In short, the MixColumns and InvMixColumns matrixes have following relation:
>  | 0e 0b 0d 09 |   | 02 03 01 01 |   | 05 00 04 00 |
>  | 09 0e 0b 0d | = | 01 02 03 01 | x | 00 05 00 04 |
>  | 0d 09 0e 0b |   | 01 01 02 03 |   | 04 00 05 00 |
>  | 0b 0d 09 0e |   | 03 01 01 02 |   | 00 04 00 05 |
>
> Bit-sliced implementation of the 05-00-04-00 matrix much shorter than 0e-0b-0d-09
> matrix, so even when combined with MixColumns total instruction count for
> InvMixColumns implemented this way should be nearly half of current.
>

That is a very useful tip, thank you. I will have a go at it and
follow up later.

Regards,
Ard.
