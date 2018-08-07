From: noloader@gmail.com (Jeffrey Walton)
Date: Mon, 6 Aug 2018 21:03:27 -0400
Subject: [PATCH] crypto: remove speck
In-Reply-To: <20180806230437.21431-1-Jason@zx2c4.com>
References: <20180806223300.113891-1-ebiggers@kernel.org>
 <20180806230437.21431-1-Jason@zx2c4.com>
Message-ID: <CAH8yC8kKet=fx0rYF8QEWK+TzyBgwHrLabWE72znBY=QLZVWkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 6, 2018 at 7:04 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> These are unused, undesired, and have never actually been used by
> anybody. The original authors of this code have changed their mind about
> its inclusion. Therefore, this patch removes it.

I think it may be unwise to completely discard Speck for several
reasons. The two biggest pain points for me are:

  - political concerns addressed by other ciphers
  - high quality lightweight block cipher implementation
  - some regulated industries will need it for their problem domains

It seems to me the political concerns were addressed by not using
Speck for Android. I don't believe HPolyC and Speck are orthogonal.
Instead they provide the user with a choice which is usually a good
thing.

I also think allowing politics a heavy hand endangers other ciphers
like SM3 and SM4. I would advise against removing them just because
they are Chinese ciphers. I suppose the same could be argued for North
Korea and Jipsam and Pilsung (if North Korea ever offers their
ciphers).

I think Eric, Ard and other contributions lead to a high quality
implementation of Speck. High quality implementations that "just
works" everywhere on multiple platforms are rather hard to come by.
The kernel's unified implementation ensures lots of folks don't go
making lots of mistakes when rolling their own.

There are verticals that will need a choice or alternative like Speck.
US Aerospace, US Automotive and US Hoteliers come to mind. US
Financial my use them too (they having some trading platforms with
absurd requirements that make Simon and Speck appear bloated and
overweight).  Some of the verticals are going to need an alternative
that meets technical and security goals and pass the audits.

Choice is a good thing. Users need choices for technical, regulatory
and legal reasons.

Jeff
