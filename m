From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 2 Oct 2018 15:12:44 +0200
Subject: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on
 CPU32v3
In-Reply-To: <CAKv+Gu8NXyfNAzk4Fe=J0QHEEV-txbRAoEcQmjG-6PgCyW5SZg@mail.gmail.com>
References: <20180930024904.14240-1-Jason@zx2c4.com>
 <CAK8P3a0grG5OBjwpTeH0fqzoFFBLDH6-oGM4ibzHypUKWedg3A@mail.gmail.com>
 <CAHmME9rVbKCNJfVBEene0SvhBEm_g7N-XJ26ugoAab1Vj7G_ww@mail.gmail.com>
 <CAK8P3a3TE8HW0wD9ETCDWMf7quDRx94-2iS6goYDQ18JQ6r=rw@mail.gmail.com>
 <CAHmME9pFnuRx2F=xeyK8d3bwv3bJY+WvE1KZn__+2oFWS0RCnA@mail.gmail.com>
 <CAKv+Gu8NXyfNAzk4Fe=J0QHEEV-txbRAoEcQmjG-6PgCyW5SZg@mail.gmail.com>
Message-ID: <CAHmME9oz2hFRjFeNSDLe59_pYn3HqB+5rWM5KsH7G_bUWaoy7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Ard,

On Tue, Oct 2, 2018 at 3:10 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> It builds but it doesn't run, at least not when built into the kernel
> proper (which will be the case after random.c moves to this library)
>
> Your toolchain is implicitly passing --fix-v4bx to the assembler,
> which causes it to permit bx instructions in ARMv4 object code, but
> tag them with special R_ARM_V4BX ELF relocations. The ARM module
> loader does take these into account, so built as a module, it works.
> However, when built into the core kernel, we have to rely on the
> linker to patch this instruction into the ARMv4 equivalent, and a
> quick check reveals that that is currently not the case.
>
> Bottom line: let's not go there.

Oh, thanks a bunch for explaining that. Since I wrote the last email
I've been playing around with as, readelf, and qemu and was slightly
mystified.

>
> > But anyway,
> > I'll go with your primary suggestion and we therefore can move ahead
> > with changing the global cflag to march=armv3m. Would you like me to
> > submit the patch for this, or would yo like to handle it?
> >
>
> Yes please go ahead.

Alright, incoming in a few minutes.

Jason
