From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 18 Nov 2016 08:55:04 +0100
Subject: [PATCH] crypto: sun4i-ss: support the Security System PRNG
In-Reply-To: <CACXcFmmMc7U1Qz6A+mvMXVnfSmOmssydcmSugo21jrX3u-95Qg@mail.gmail.com>
References: <1476794067-28563-1-git-send-email-clabbe.montjoie@gmail.com>
 <CACXcFmmMc7U1Qz6A+mvMXVnfSmOmssydcmSugo21jrX3u-95Qg@mail.gmail.com>
Message-ID: <20161118075504.GA21827@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 08:07:09PM -0500, Sandy Harris wrote:
> Add Ted T'so to cc list. Shouldn't he be included on anything affecting
> the random(4) driver?
> 

Blindy used get_maintainer.pl, and since the file is in crypto, hw_random people were not set.
Note that get_maintainer.pl on drivers/char/hw_random/, does not give his address also.
My V2 patch will have them in CC/TO.

> On Tue, Oct 18, 2016 at 8:34 AM, Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> 
> > From: LABBE Corentin <clabbe.montjoie@gmail.com>
> >
> > The Security System have a PRNG.
> > This patch add support for it as an hwrng.
> 
> Which is it? A PRNG & a HW RNG are quite different things.
> It would, in general, be a fairly serious error to treat a PRNG
> as a HWRNG.
> 
> If it is just a prng (which it appears to be from a quick look
> at your code) then it is not clear it is useful since the
> random(4) driver already has two PRNGs. It might be
> but I cannot tell.

For me hwrng is a way to give user space an another way to get "random" data via /dev/hwrng.
The only impact of hwrng with random is that just after init some data of hwrng is used for having more entropy.

Grepping prng in drivers/char/hw_random/ and drivers/crypto show me some other PRNG used with hwrng.

Regards
Corentin Labbe
