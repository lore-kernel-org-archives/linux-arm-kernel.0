From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 8 Jul 2016 09:19:04 -0700
Subject: [PATCH 0/9] mm: Hardened usercopy
In-Reply-To: <20160708084639.GA4562@gmail.com>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
 <20160708084639.GA4562@gmail.com>
Message-ID: <CA+55aFzv4kQitzhWgxRAi5XXM30f70d4dbTGkr7t=fZSh4r3Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 8, 2016 at 1:46 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> Could you please try to find some syscall workload that does many small user
> copies and thus excercises this code path aggressively?

Any stat()-heavy path will hit cp_new_stat() very heavily. Think the
usual kind of "traverse the whole tree looking for something". "git
diff" will do it, just checking that everything is up-to-date.

That said, other things tend to dominate.

                 Linus
