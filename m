From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 15 Oct 2017 23:38:31 +0800
Subject: [PATCH v9 00/20] simplify crypto wait for async op
In-Reply-To: <1508059209-25529-1-git-send-email-gilad@benyossef.com>
References: <1508059209-25529-1-git-send-email-gilad@benyossef.com>
Message-ID: <20171015153831.GA22867@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 15, 2017 at 10:19:45AM +0100, Gilad Ben-Yossef wrote:
>
> Changes from v8:
> - Remove the translation of EAGAIN return code to the
>   previous return code of EBUSY for the user space
>   interface of algif as no one seems to rely on it as
>   requested by Herbert Xu.

Sorry, but I forgot to mention that EAGAIN is not a good value
to use because it's used by the network system calls for other
meanings (interrupted by a signal).

So if we stop doing the translation then we also need to pick
a different value, perhaps E2BIG or something similar that have
no current use within the crypto API or network API.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
