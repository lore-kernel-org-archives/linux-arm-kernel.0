From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 5 Oct 2018 19:15:13 +0200
Subject: [RFC PATCH 0/9] patchable function pointers for pluggable crypto
 routines
In-Reply-To: <20181005133705.GA4588@zx2c4.com>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005133705.GA4588@zx2c4.com>
Message-ID: <CAKv+Gu-f4uKBF=gtFcNJEeoC2L4qShX0+3p7kVhjTn0tR+3Gng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2018 at 15:37, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
...
> Therefore, I think this patch goes in exactly the wrong direction. I
> mean, if you want to introduce dynamic patching as a means for making
> the crypto API's dynamic dispatch stuff not as slow in a post-spectre
> world, sure, go for it; that may very well be a good idea. But
> presenting it as an alternative to Zinc very widely misses the point and
> serves to prolong a series of bad design choices, which are now able to
> be rectified by putting energy into Zinc instead.
>

This series has nothing to do with dynamic dispatch: the call sites
call crypto functions using ordinary function calls (although my
example uses CRC-T10DIF), and these calls are redirected via what is
essentially a PLT entry, so that we can supsersede those routines at
runtime.
