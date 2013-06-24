From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Jun 2013 15:04:24 +0100
Subject: [PATCH] ARM: Add support for LPAE style CONTEXTIDR
In-Reply-To: <1372080405-13365-1-git-send-email-cov@codeaurora.org>
References: <1372080405-13365-1-git-send-email-cov@codeaurora.org>
Message-ID: <20130624140424.GA24861@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On Mon, Jun 24, 2013 at 02:26:45PM +0100, Christopher Covington wrote:
> Using the long-descriptor translation table format changes
> the layout of the CONTEXTIDR register.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
>  arch/arm/mm/context.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)

Hmm, I'd deliberately written the code as-is, so that debuggers wouldn't
need context-sensitive parsing of the contextidr register depending on the
type of page tables in use.

What's the advantage of this approach, other than you get an extra byte's
worth of PID?

Will
