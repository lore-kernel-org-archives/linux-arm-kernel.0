From: sandyinchina@gmail.com (Sandy Harris)
Date: Thu, 17 Nov 2016 20:07:09 -0500
Subject: [PATCH] crypto: sun4i-ss: support the Security System PRNG
In-Reply-To: <1476794067-28563-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1476794067-28563-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <CACXcFmmMc7U1Qz6A+mvMXVnfSmOmssydcmSugo21jrX3u-95Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Ted T'so to cc list. Shouldn't he be included on anything affecting
the random(4) driver?

On Tue, Oct 18, 2016 at 8:34 AM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:

> From: LABBE Corentin <clabbe.montjoie@gmail.com>
>
> The Security System have a PRNG.
> This patch add support for it as an hwrng.

Which is it? A PRNG & a HW RNG are quite different things.
It would, in general, be a fairly serious error to treat a PRNG
as a HWRNG.

If it is just a prng (which it appears to be from a quick look
at your code) then it is not clear it is useful since the
random(4) driver already has two PRNGs. It might be
but I cannot tell.
