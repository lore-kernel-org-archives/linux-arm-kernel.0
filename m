From: stockhausen@collogia.de (Markus Stockhausen)
Date: Thu, 25 Jun 2015 06:32:31 +0000
Subject: AW: [PATCH] md/raid6: delta syndrome for ARM NEON
In-Reply-To: <1435164213-25410-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1435164213-25410-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <12EF8D94C6F8734FB2FF37B9FBEDD1735FCC7052@EXCHANGE.collogia.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Von: Ard Biesheuvel [ard.biesheuvel at linaro.org]
> Gesendet: Mittwoch, 24. Juni 2015 18:43
> An: linux-arm-kernel at lists.infradead.org; hpa at zytor.com
> Cc: Ard Biesheuvel; Markus Stockhausen; Neil Brown
> Betreff: [PATCH] md/raid6: delta syndrome for ARM NEON
> 
> This implements XOR syndrome calculation using NEON intrinsics.
> As before, the module can be built for ARM and arm64 from the
> same source.

> Relative performance on a Cortex-A57 based system:
> 
>   raid6: int64x1  gen()   905 MB/s
>   raid6: int64x1  xor()   881 MB/s
>   raid6: int64x2  gen()  1343 MB/s
>   raid6: int64x2  xor()  1286 MB/s
>   raid6: int64x4  gen()  1896 MB/s
>   raid6: int64x4  xor()  1321 MB/s
>   raid6: int64x8  gen()  1773 MB/s
>   raid6: int64x8  xor()  1165 MB/s
>   raid6: neonx1   gen()  1834 MB/s
>   raid6: neonx1   xor()  1278 MB/s
>   raid6: neonx2   gen()  2528 MB/s
>   raid6: neonx2   xor()  1942 MB/s
>   raid6: neonx4   gen()  2888 MB/s
>   raid6: neonx4   xor()  2334 MB/s
>   raid6: neonx8   gen()  2957 MB/s
>   raid6: neonx8   xor()  2232 MB/s
>   raid6: using algorithm neonx8 gen() 2957 MB/s
>   raid6: .... xor() 2232 MB/s, rmw enabled
>

Nice to see that the placeholders get filled. 
Did you have a chance to do some real tests?

Markus

> 
> Cc: Markus Stockhausen <stockhausen@collogia.de>
> Cc: Neil Brown <neilb@suse.de>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> ...
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: InterScan_Disclaimer.txt
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150625/23b4482f/attachment.txt>
