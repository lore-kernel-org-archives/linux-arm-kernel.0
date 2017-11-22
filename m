From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Nov 2017 12:17:08 +0000
Subject: [PATCH] crypto/arm64: aes-ce-cipher - move assembler code to .S
 file
In-Reply-To: <20171122120457.cf47mwmg4pudzoy4@lakrids.cambridge.arm.com>
References: <20171121134017.21247-1-ard.biesheuvel@linaro.org>
 <20171122100558.717b7973@delmar.localdomain>
 <CAKv+Gu8Tde_yu-3MWFEgdaWDWtf1SssUAMc1s396zL=J-j+buA@mail.gmail.com>
 <20171122120457.cf47mwmg4pudzoy4@lakrids.cambridge.arm.com>
Message-ID: <20171122121708.rw7zxmomhao3jnzc@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 12:04:58PM +0000, Mark Rutland wrote:
> On Wed, Nov 22, 2017 at 10:12:17AM +0000, Ard Biesheuvel wrote:
> > On 22 November 2017 at 10:05, Alex Matveev <alxmtvv@gmail.com> wrote:
> > > This is better than my simple fix, thank you.
> > >
> > > Out of curiosity, why doesn't NEON code use barrier() to prevent
> > > reordering?
> > 
> > Because barrier() affects ordering of memory accesses, not register accesses.
> 
> My understanding was that barrier() also hazards with any volatile asm
> (and that in general, volatile asm block couldn't be re-ordered w.r.t.
> one another). I'm sure we rely on this, even if it's not true. :/

>From a quick scan, certainly in tls_thread_flush(),
compat_arm_syscall(), elsewhere where we have isb() and other helpers
like {read,write}_sysreg().

Mark.
