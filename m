From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 6 Sep 2018 16:51:00 +0800
Subject: [PATCH 2/2] crypto: skcipher: Remove VLA usage for
 SKCIPHER_REQUEST_ON_STACK
In-Reply-To: <CAKv+Gu-QkCE0pY4+5anEZ0eWv-FTH1QJtOQfPcTVLcvNf7XNiA@mail.gmail.com>
References: <20180904181629.20712-1-keescook@chromium.org>
 <20180904181629.20712-3-keescook@chromium.org>
 <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com>
 <CAGXu5jKmcuhULMR=O9B_hJAxEK8uV36uoMxm4F3F8yYSuMzYNA@mail.gmail.com>
 <CAKv+Gu_0vWUqkUex45iW=pAfUbKVsqzP9MDf6OOwTg-nUVPZNg@mail.gmail.com>
 <CAOtvUMfu4-DWD4n4c5itjArAYWhGaBnPBEnkh6cbCubG-k9cCA@mail.gmail.com>
 <CAKv+Gu8bKcPksgoryaVjoD9G5KeCYrqWOCgVhqrBqGw5dCzXag@mail.gmail.com>
 <CAKv+Gu-QkCE0pY4+5anEZ0eWv-FTH1QJtOQfPcTVLcvNf7XNiA@mail.gmail.com>
Message-ID: <20180906085100.xcqqftgqg4sizkec@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 10:11:59AM +0200, Ard Biesheuvel wrote:
>
> That way, we will almost certainly oops on a NULL pointer dereference
> right after, but we at least the stack corruption.

A crash is just as bad as a BUG_ON.

Is this even a real problem? Do we have any users of this construct
that is using it on async algorithms?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
