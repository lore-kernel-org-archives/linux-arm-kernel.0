From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Wed, 26 Sep 2018 19:46:36 +0200
Subject: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64
 implementations
In-Reply-To: <20180926173720.GA248906@gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
 <CAHmME9p5b=L0FSL72gCszhvut-kr=aD4ZniY9qsJxiBnZk8qNQ@mail.gmail.com>
 <20180926173720.GA248906@gmail.com>
Message-ID: <CAHmME9ou-4JvvuRntwUf-BCQpnsHP4d+T0V8_XPSQ8jQ4G2Rpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 7:37 PM Eric Biggers <ebiggers@kernel.org> wrote:
> Can you please stop accusing Ard of "filibustering" your patchset?  Spending too
> long in non-preemptible code is a real problem even on non-RT systems.
> syzkaller has been reporting bugs where the kernel spins too long without any
> preemption points, both in crypto-related code and elsewhere in the kernel.  So
> we've had to add explicit preemption points to address those, as otherwise users
> can lock up all CPUs for tens of seconds.  The issue being discussed here is
> basically the same except here preemption is being explicitly disabled via
> kernel_neon_begin(), so it becomes a problem even on non-CONFIG_PREEMPT kernels.

The async distraction (re:filibustering) and the preempt concern are
two totally different things. I've already posted some code elsewhere
in this thread that addresses the preempt issue that looked good to
Ard. This will be part of v7.
