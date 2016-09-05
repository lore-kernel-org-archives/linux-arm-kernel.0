From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Sep 2016 10:02:44 +0100
Subject: [PATCH v3 1/7] arm64: kernel: fix style issues in sleep.S
In-Reply-To: <CAKv+Gu-2zkhw++tBqP6BA+B_a5D6t0BpRg9KxqCgdLCHY53ADw@mail.gmail.com>
References: <1472641517-15362-1-git-send-email-ard.biesheuvel@linaro.org>
 <1472641517-15362-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu-2zkhw++tBqP6BA+B_a5D6t0BpRg9KxqCgdLCHY53ADw@mail.gmail.com>
Message-ID: <20160905090244.GA2649@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Sat, Sep 03, 2016 at 09:08:13PM +0100, Ard Biesheuvel wrote:
> On 31 August 2016 at 12:05, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > This fixes a number of style issues in sleep.S. No functional changes are
> > intended:
> > - replace absolute literal references with relative references in
> >   __cpu_suspend_enter(), which executes from its virtual address
> > - replace explicit lr assignment plus branch with bl in cpu_resume(), which
> >   aligns it with stext() and secondary_startup()
> > - don't export _cpu_resume()
> 
> Apologies, I sent out the wrong version of this patch in v3. Not
> exporting _cpu_resume() breaks hibernate, so I dropped it from v2
> (which is the version that Mark reviewed), but I reintroduced it by
> accident.

No problem, these things happen.

> Please let me know how you would like to proceed, i.e., put a fixup on
> top, or resend.

I already pushed this out on for-next/core, so please send a fixup on top.
I could've sworn I did an allmodconfig build test before pushing out, but
apparently not.

Will
