From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 15 Nov 2018 15:10:48 -0800
Subject: [PATCHv3 1/6] atomics: add common header generation files
In-Reply-To: <20180904104830.2975-2-mark.rutland@arm.com>
References: <20180904104830.2975-1-mark.rutland@arm.com>
 <20180904104830.2975-2-mark.rutland@arm.com>
Message-ID: <20181115151048.26244bad301a3bcb9a450060@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  4 Sep 2018 11:48:25 +0100 Mark Rutland <mark.rutland@arm.com> wrote:

> To minimize repetition, to allow for future rework, and to ensure
> regularity of the various atomic APIs, we'd like to automatically
> generate (the bulk of) a number of headers related to atomics.
> 
> This patch adds the infrastructure to do so, leaving actual conversion
> of headers to subsequent patches.

This thing is appallingly slow.  `sh scripts/atomic/check-atomics.sh'
takes 8 seconds on a machine which builds an allnoconfig kernel in 30
seconds.

Um, no.  Just no.  Please find a way to make this overhead go away.
