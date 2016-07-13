From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 13 Jul 2016 15:01:28 -0700
Subject: [PATCH v2 01/11] mm: Implement stack frame object validation
In-Reply-To: <1468446964-22213-2-git-send-email-keescook@chromium.org>
References: <1468446964-22213-1-git-send-email-keescook@chromium.org>
 <1468446964-22213-2-git-send-email-keescook@chromium.org>
Message-ID: <CALCETrVDJDjdoh7yvOPd=_5twQnzQRhe8G2KLaRw-NnA1Uf__g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 2:55 PM, Kees Cook <keescook@chromium.org> wrote:
> This creates per-architecture function arch_within_stack_frames() that
> should validate if a given object is contained by a kernel stack frame.
> Initial implementation is on x86.
>
> This is based on code from PaX.
>

This, along with Josh's livepatch work, are two examples of unwinders
that matter for correctness instead of just debugging.  ISTM this
should just use Josh's code directly once it's been written.

--Andy
