From: david@gibson.dropbear.id.au (David Gibson)
Date: Sun, 9 Mar 2014 22:43:19 +1100
Subject: [PATCH RFC 1/5] dtc: Add helpers for various message levels
In-Reply-To: <1392919611-10746-2-git-send-email-t.figa@samsung.com>
References: <1392919611-10746-1-git-send-email-t.figa@samsung.com>
 <1392919611-10746-2-git-send-email-t.figa@samsung.com>
Message-ID: <20140309114319.GF20356@voom.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 07:06:47PM +0100, Tomasz Figa wrote:
> This patch adds three helper macros to print errors, warnings and
> informational messages using standard format.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  dtc.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/dtc.h b/dtc.h
> index 20de073..e95bed7 100644
> --- a/dtc.h
> +++ b/dtc.h
> @@ -43,6 +43,9 @@
>  #define debug(fmt,args...)
>  #endif
>  
> +#define pr_err(...)	fprintf (stderr, "ERROR: " __VA_ARGS__)
> +#define pr_warn(...)	fprintf (stderr, "WARNING: " __VA_ARGS__)
> +#define pr_info(...)	fprintf (stderr, "INFO: " __VA_ARGS__)

So, there are already several message helper functions in dtc.
They're not all that consistently applied, so I can see an argument
for cleaning things up, and replacing them with ones modelled on the
kernel versions like these.

But.. this patch doesn't do that, it just adds yet another variant to
the mix.

In addition, what we want for messages in dtc is a bit different from
the kernel - the kernel's expexted to keep running, and the messages
log events of interest.  For dtc, for each warning/error you should
also be deciding whether that should terminate the program or not -
these helpers don't address that.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140309/40f9c367/attachment-0001.sig>
