From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 30 Nov 2017 09:34:43 -0800
Subject: [PATCH 2/3] kbuild: add cc-if-name-version and compiler-specific
 variants
In-Reply-To: <CAK7LNAQg4+eyR-mggswxvkBSxrdwFTQ3A733cSs4965UzO0qgQ@mail.gmail.com>
References: <20171129000011.55235-1-samitolvanen@google.com>
 <20171129000011.55235-3-samitolvanen@google.com>
 <CAK7LNAQg4+eyR-mggswxvkBSxrdwFTQ3A733cSs4965UzO0qgQ@mail.gmail.com>
Message-ID: <20171130173443.GA90451@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 09:21:49PM +0900, Masahiro Yamada wrote:
> BTW, did this patch work in your test?

Yes, but it looks like /bin/sh is symlinked to bash on my system. I can
reproduce the issue with dash.

> As for the macro names, maybe
> 
> __cc-ifversion, __cc-if-fullversion for consistency?

> I think you can do like follows to avoid code duplication.
> 
> # backward compatibility
> cc-ifversion = $(gcc-ifversion)
> cc-if-fullversion = $(gcc-if-fullversion)

Sure, both changes sound good to me. I'll fix these in v2.

Sami
