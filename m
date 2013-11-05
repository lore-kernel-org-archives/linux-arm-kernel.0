From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 5 Nov 2013 17:01:50 +0100
Subject: [PATCH v2 01/13] uprobes: move function declarations out of arch
In-Reply-To: <1381871068-27660-2-git-send-email-dave.long@linaro.org>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
 <1381871068-27660-2-git-send-email-dave.long@linaro.org>
Message-ID: <20131105160150.GA1539@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15, David Long wrote:
>
> Move the function declarations from the arch header to the common
> header, since only the function bodies are architecture-specific.
> These changes are from Vincent Rabin's uprobes patch.

Hmm. I didn't look at this patch because I thought it is obviously
fine, but...

>  arch/x86/include/asm/uprobes.h | 7 -------
>  include/linux/uprobes.h        | 8 ++++++++
>  2 files changed, 8 insertions(+), 7 deletions(-)

it should also update arch/powerpc/include/asm/uprobes.h ?

And 12/13 should not touch arch/powerpc/ or include/linux/uprobes.h.

Oleg.
