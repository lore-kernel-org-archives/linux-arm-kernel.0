From: paulcrowley@google.com (Paul Crowley)
Date: Tue, 24 Apr 2018 21:58:32 +0000
Subject: [PATCH v2 0/5] crypto: Speck support
In-Reply-To: <CAHmME9qG+nPmj5c7hU4+STUsmWmwSBsKe-0mOLEXH+hJ1z4z=g@mail.gmail.com>
References: <20180212235209.117393-1-ebiggers@google.com>
 <CAHmME9oA4j=iGrrBYME92JfUsyi5r42PnAvzWiuXzGCRXMnXtA@mail.gmail.com>
 <20180424181623.GA174675@google.com>
 <CAHmME9qG+nPmj5c7hU4+STUsmWmwSBsKe-0mOLEXH+hJ1z4z=g@mail.gmail.com>
Message-ID: <CA+_SqcAjXkunPErsQ3LomTcANjm3sTQQq3j=YN_fFTv+Rg8z2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Apr 2018 at 13:58, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Tue, Apr 24, 2018 at 8:16 PM, Eric Biggers <ebiggers@google.com> wrote:
> > So, what do you propose replacing it with?

> Something more cryptographically justifiable.

I'm keen to hear recommendations here, if there are options we should be
considering I'd like to know about them.

> That's the thing that worries me, actually. Many of the design
> decisions behind Speck haven't been justified.

It seems to me justified about as well as one would hope for a new cipher -
  "Notes on the design and analysis of Simon and Speck" seems to me to give
more detail on the reasoning than went into eg Salsa20, which I think also
hit a perfectly acceptable bar and was a good choice for adding to the
Linux kernel. Of course it's building on the fairly detailed understanding
we now have of how to build a secure ARX cipher. Given what a prize
cryptanalysis of an NSA-designed block cipher would be for anyone in the
field, the sheer simplicity and straightforwardness of the design, taken
with the very large gap between the full cipher and the best cryptanalysis,
and drawing on my own experience attacking Salsa20, I feel pretty good
about fielding this design. But if you have a specific alternative in mind
- a 128-bit block cipher (so we can use it in XTS mode) which is fast and
side-channel-free on ARM processors with NEON but without ARM CE - I'm very
keen to hear about it.

Could you say a little more about what it is that separates Speck from SM4
for you?

Thanks!
