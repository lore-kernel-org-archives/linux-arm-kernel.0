From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Wed, 26 Sep 2018 17:41:12 +0200
Subject: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64
 implementations
In-Reply-To: <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
Message-ID: <CAHmME9p5b=L0FSL72gCszhvut-kr=aD4ZniY9qsJxiBnZk8qNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 4:02 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> I don't think it makes sense to keep
> it simple now and add the complexity later (and the same concern
> applies to async support btw).

Ugh, no. I don't want to add needless complexity, period. Zinc is
synchronous, not asynchronous. It provides software implementations.
That's what it does. While many of your reviews have been useful, many
of your comments indicate some desire to change and mold the purpose
and focus of Zinc away from Zinc's intents. Stop that. It's not going
to become a bloated mess of "things Ard wanted and quipped about on
LKML." Things like these only serve to filibuster the patchset
indefinitely. But maybe that's what you'd like all along? Hard to
tell, honestly. So, no, sorry, Zinc isn't gaining an async interface
right now.
