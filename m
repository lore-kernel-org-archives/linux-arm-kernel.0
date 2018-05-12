From: bp@alien8.de (Borislav Petkov)
Date: Sat, 12 May 2018 12:33:31 +0200
Subject: [PATCH] edac: altera: Add Stratix10 SDRAM Uncorrectable Errors
In-Reply-To: <1526079610-5527-1-git-send-email-thor.thayer@linux.intel.com>
References: <1526079610-5527-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <20180512103331.GC27593@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 06:00:10PM -0500, thor.thayer at linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> On Stratix10, uncorrectable errors are routed to the SError
> exception instead of the IRQ exceptions. In Stratix10,
> uncorrectable SErrors must be treated as fatal and will cause
> a panic.
> Older Altera/Intel parts printed out a message for UE so do
> that here using the notifier framework.
> 
> Record the UE in sticky registers that retain the state
> through a reset. Check these registers on probe and printout the
> error on startup.
> 
> Depends on previous patch:
> commit 2a4ff60626b0 ("arm64: dts: stratix10: add sdram ecc")
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>  drivers/edac/altera_edac.c | 67 +++++++++++++++++++++++++++++++++++++++-------
>  drivers/edac/altera_edac.h |  8 +++++-
>  2 files changed, 64 insertions(+), 11 deletions(-)

Ok, I think I have collected everything. Pls double-check me I haven't missed
anything:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=for-next

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
