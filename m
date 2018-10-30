From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 30 Oct 2018 19:17:24 +1100
Subject: [RFC PATCH v2 11/12] crypto: adiantum - add Adiantum support
In-Reply-To: <20181024220614.GA13497@gmail.com>
References: <20181015175424.97147-1-ebiggers@kernel.org>
 <20181015175424.97147-12-ebiggers@kernel.org>
 <CAKv+Gu9wrOOk-LGPYmxgLbv86uXzMeHN6th3mMEDT3Vg893HWw@mail.gmail.com>
 <20181020071206.GE876@sol.localdomain>
 <CAKv+Gu9zBKK7ughbBAKkHdfgX2KrBXkF6MhH3xrSdLegrjjYJQ@mail.gmail.com>
 <20181024220614.GA13497@gmail.com>
Message-ID: <20181030081724.GA2730@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 03:06:17PM -0700, Eric Biggers wrote:
>
> The patch I've been using just exposes a file /proc/cryptobench (note: it maybe
> should be made into a char device instead) to which you can write commands like:
> 
> 	algtype=skcipher algname=adiantum(xchacha12,aes) keysize=32 bufsize=4096 niter=1000
> 
> Then userspace reads back the result:
> 
> 	SUCCESS algname=adiantum(xchacha12,aes) driver_name=adiantum(xchacha12-software,aes-aesni,nhpoly1305-generic) measurement=0x30a5abd5776e0af enc_time=44831104 dec_time=38303077
> 
> It's then pretty straightforward to wrap this API in a userspace script that
> does all the benchmarks you need, and formats the results nicely.
> 
> For correctness testing there's also an option 'sgl_fuzz' that randomizes the
> scatterlist division.
> 
> Currently the patch is missing some features such as AEAD support, but at some
> point I'd like to get it into a state where it can be included upstream.

I completely agree that a new interface would be much better for
tcrypt.

However, we're trying to avoid using /proc for new APIs.  So perhaps
netlink would be a better choice given the existing configuration and
stats APIs that already exist for it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
