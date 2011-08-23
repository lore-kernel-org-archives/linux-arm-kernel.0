From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2011 12:15:33 +0100
Subject: [PATCH v7 03/16] ARM: LPAE: Use PMD_(SHIFT|SIZE|MASK) instead
	of PGDIR_*
In-Reply-To: <1312988619-16804-4-git-send-email-catalin.marinas@arm.com>
References: <1312988619-16804-1-git-send-email-catalin.marinas@arm.com>
	<1312988619-16804-4-git-send-email-catalin.marinas@arm.com>
Message-ID: <20110823111533.GH19622@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 04:03:26PM +0100, Catalin Marinas wrote:
> @@ -183,7 +183,7 @@ static int __init consistent_init(void)
>  		}
>  
>  		consistent_pte[i++] = pte;
> -		base += (1 << PGDIR_SHIFT);
> +		base += (1 << PMD_SHIFT);

Please replace with PMD_SIZE.

Once combined with the "fixup! ARM: LPAE: Use PMD_(SHIFT|SIZE|MASK) instead of PGDIR_*"
patch (and once whatever "fixup!" is done) this can be submitted to the
patch system.
