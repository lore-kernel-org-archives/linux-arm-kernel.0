From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 24 Apr 2018 22:58:35 +0200
Subject: [PATCH v2 0/5] crypto: Speck support
In-Reply-To: <20180424181623.GA174675@google.com>
References: <20180212235209.117393-1-ebiggers@google.com>
 <CAHmME9oA4j=iGrrBYME92JfUsyi5r42PnAvzWiuXzGCRXMnXtA@mail.gmail.com>
 <20180424181623.GA174675@google.com>
Message-ID: <CAHmME9qG+nPmj5c7hU4+STUsmWmwSBsKe-0mOLEXH+hJ1z4z=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Tue, Apr 24, 2018 at 8:16 PM, Eric Biggers <ebiggers@google.com> wrote:
> So, what do you propose replacing it with?

Something more cryptographically justifiable.

> outside crypto review, vs. the many cryptanalysis papers on Speck.  (In that
> respect the controversy about Speck has actually become an advantage, as it has
> received much more cryptanalysis than other lightweight block ciphers.)

That's the thing that worries me, actually. Many of the design
decisions behind Speck haven't been justified.

> The reason we chose Speck had nothing to do with the proposed ISO standard or
> any sociopolitical factors, but rather because it was the only algorithm we
> could find that met the performance and security requirements.

> Note that Linux
> doesn't bow down to any particular standards organization, and it offers
> algorithms that were specified in various places, even some with no more than a
> publication by the author.  In fact, support for SM4 was just added too, which
> is a Chinese government standard.  Are you going to send a patch to remove that
> too, or is it just NSA designed algorithms that are not okay?

No need to be belittling; I have much less tinfoil strapped around my
head than perhaps you think. I'm not blindly opposed to
government-designed algorithms. Take SHA2, for example -- built by the
NSA.

But I do care quite a bit about using ciphers that have acceptance of
the academic community and a large body of literature documenting its
design decisions and analyzing it. Some of the best symmetric
cryptographers in academia have expressed reservations about it, and
it was just rejected from a major standard's body. Linux, of course,
is free to disagree -- or "bow down" as you oddly put it -- but I'd
make sure you've got a pretty large bucket of justifications for that
disagreement.

> (in fact, you'd
> probably have a different opinion of it if the authors had simply worked
> somewhere else and published the exact same algorithm);

Again, no need to patronize. I don't actually have a bias like that.

> But I hope you can understand that all *technical* indicators are that Speck is
> secure enough

That's the thing I'm worried about.

Jason
