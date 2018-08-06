From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 7 Aug 2018 01:16:18 +0200
Subject: [RFC PATCH 3/9] crypto: chacha20-generic - refactor to allow
 varying number of rounds
In-Reply-To: <20180806223300.113891-4-ebiggers@kernel.org>
References: <20180806223300.113891-1-ebiggers@kernel.org>
 <20180806223300.113891-4-ebiggers@kernel.org>
Message-ID: <CAHmME9rbe6eT6dkUqKnp-GxcqGrp-tvMfTMr8kZtsn=S3cmP8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Eric,

On Tue, Aug 7, 2018 at 12:35 AM Eric Biggers <ebiggers@kernel.org> wrote:
> In preparation for adding XChaCha12 support, rename/refactor
> chacha20-generic to support different numbers of rounds.

I'm interested in learning the motivation behind going with ChaCha12.
So far, the vast majority of users of ChaCha have been getting along
quite fine with ChaCha20 and enjoying the very large security margin
this provides. In some ways, introducing ChaCha12 into the ecosystem
feels like a bit of a step backwards, even if it probably still
provides adequate security (though ChaCha8 probably shouldn't be used
or included at all). I realize the simple answer is just, "because
it's faster." But I'm wondering specifically about the speed
requirements and on what hardware and in what circumstances you found
ChaCha20 was too slow, and if this is the kind of circumstance you
expect to persist into the future.

Jason
