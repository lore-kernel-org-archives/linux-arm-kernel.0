From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Apr 2018 21:56:02 +0200
Subject: [PATCHv3 06/11] asm-generic: mm_hooks: allow hooks to be
 overridden individually
In-Reply-To: <20180417183735.56985-7-mark.rutland@arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com>
 <20180417183735.56985-7-mark.rutland@arm.com>
Message-ID: <CAK8P3a3SVhW1ByQOtxw7JG8i3wWU5opdycfSCTbW=GCFvBJmQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 8:37 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Currently, an architecture must either implement all of the mm hooks
> itself, or use all of those provided by the asm-generic implementation.
> When an architecture only needs to override a single hook, it must copy
> the stub implementations from the asm-generic version.
>
> To avoid this repetition, allow each hook to be overridden indiviually,
> by placing each under an #ifndef block. As architectures providing their
> own hooks can't include this file today, this shouldn't adversely affect
> any existing hooks.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch at vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
