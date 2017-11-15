From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 15 Nov 2017 14:06:14 -0800
Subject: [PATCH v2 03/18] kbuild: move gcc-version.sh to cc-version.sh
 and add clang support
In-Reply-To: <CAGXu5jL0B18ijuFxySBzcOtju3DL-UZfb39mWLxww5SJ5P3Feg@mail.gmail.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-4-samitolvanen@google.com>
 <CAGXu5jL0B18ijuFxySBzcOtju3DL-UZfb39mWLxww5SJ5P3Feg@mail.gmail.com>
Message-ID: <20171115220614.GA27176@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 01:48:52PM -0800, Kees Cook wrote:
> It might make sense to split this patch: do the move and refactoring,
> then add clang support.

Sure.

> Though, won't this confuse some tests? A lot of cc-version tests are
> expecting only gcc, yes?

There's already a chance of this happening with cc-version. Currently,
gcc-version.sh returns 0402 for clang 5.0, which probably doesn't have
the same issues as gcc 4.2 did.

While I didn't see anything new that would break on platforms that
clang can currently compile, you're correct, we should probably have a
macro that also checks for the compiler, or have separate macros for
different compilers.

I'll address these in v3.

Sami
