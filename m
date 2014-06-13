From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 13 Jun 2014 13:41:02 -0700
Subject: [PATCH v6 6/9] seccomp: add "seccomp" syscall
In-Reply-To: <1402457121-8410-7-git-send-email-keescook@chromium.org>
References: <1402457121-8410-1-git-send-email-keescook@chromium.org>
 <1402457121-8410-7-git-send-email-keescook@chromium.org>
Message-ID: <CALCETrVYVB0pMj61T9ZCAhgL6WYHAdDjiDe81O0e4tTQLtjDiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 8:25 PM, Kees Cook <keescook@chromium.org> wrote:
> This adds the new "seccomp" syscall with both an "operation" and "flags"
> parameter for future expansion. The third argument is a pointer value,
> used with the SECCOMP_SET_MODE_FILTER operation. Currently, flags must
> be 0. This is functionally equivalent to prctl(PR_SET_SECCOMP, ...).

Question for the linux-abi people:

What's the preferred way to do this these days?  This syscall is a
general purpose "adjust the seccomp state" thing.  The alternative
would be a specific new syscall to add a filter with a flags argument.

--Andy
