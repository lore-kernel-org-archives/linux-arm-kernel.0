From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 7 Jul 2016 21:34:53 +0200 (CEST)
Subject: [PATCH 1/9] mm: Hardened usercopy
In-Reply-To: <CAGXu5jJWVow4i_M7Qg4ZFgZh3k_fUxUs4pDJSf5Yc8Q-FK9HoQ@mail.gmail.com>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
 <1467843928-29351-2-git-send-email-keescook@chromium.org>
 <alpine.DEB.2.11.1607070938430.4083@nanos>
 <CAGXu5jJWVow4i_M7Qg4ZFgZh3k_fUxUs4pDJSf5Yc8Q-FK9HoQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1607072133550.4083@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jul 2016, Kees Cook wrote:
> On Thu, Jul 7, 2016 at 3:42 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > I'd rather make that a weak function returning 1 which can be replaced by
> > x86 for CONFIG_FRAME_POINTER=y. That also allows other architectures to
> > implement their specific frame checks.
> 
> Yeah, though I prefer CONFIG-controlled stuff over weak functions, but
> I agree, something like arch_check_stack_frame(...) or similar. I'll
> build something for this on the next revision.

I'm fine with CONFIG_CONTROLLED as long as the ifdeffery is limited to header
files.

Thanks,

	tglx
