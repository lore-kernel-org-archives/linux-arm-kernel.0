From: pageexec@freemail.hu (PaX Team)
Date: Thu, 18 Feb 2016 11:46:42 +0100
Subject: [PATCH] ARM: vdso: Mark vDSO code as read-only
In-Reply-To: <CAGXu5jJmpq_2mmTLD0VbnY1SBF5b5Rr04HKWfD1LEaGxnztFdQ@mail.gmail.com>
References: <1453226922-16831-1-git-send-email-keescook@chromium.org>,
 <20160217234306.GA59532@davidb.org>,
 <CAGXu5jJmpq_2mmTLD0VbnY1SBF5b5Rr04HKWfD1LEaGxnztFdQ@mail.gmail.com>
Message-ID: <56C5A112.25195.35DDEA@pageexec.freemail.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 Feb 2016 at 15:48, Kees Cook wrote:

> On Wed, Feb 17, 2016 at 3:43 PM, David Brown <david.brown@linaro.org> wrote:

> > Is there a possible future consideration to perhaps make .rodata read
> > only much earlier?
> 
> Yeah, this will likely be a future improvement. Some architectures
> already mark .rodata before the mark_rodata_ro() call. Once we start
> to have more use of postinit-readonly, I suspect we'll see more
> clarification of when those things happen.

FYI, PaX had enforced early rodata on i386 during the 2.4 series (i.e.,
decade+ ago) but i abandoned it for 2.6 due to the maintenance burden
coupled with its low benefit...
