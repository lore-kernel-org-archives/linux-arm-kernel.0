From: olof@lixom.net (Olof Johansson)
Date: Wed, 30 Jul 2014 12:54:24 -0700
Subject: [PATCH] drivers: CCI: Correct use of ! and &
In-Reply-To: <1406716655-32494-1-git-send-email-punit.agrawal@arm.com>
References: <1406716655-32494-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <20140730195424.GG18384@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 11:37:35AM +0100, Punit Agrawal wrote:
> From: Himangi Saraogi <himangi774@gmail.com>
> 
> In commit ae91d60ba88ef0bdb1b5e9b2363bd52fc45d2af7, a bug was fixed that
> involved converting !x & y to !(x & y).  The code below shows the same
> pattern, and thus should perhaps be fixed in the same way.
> 
> The Coccinelle semantic patch that makes this change is as follows:
> 
> // <smpl>
> @@ expression E1,E2; @@
> (
>   !E1 & !E2
> |
> - !E1 & E2
> + !(E1 & E2)
> )
> // </smpl>
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> Acked-by: Punit Agrawal <punit.agrawal@arm.com>
> ---

Thanks, applied (adding a Fixes: tag, please use those in the future)


-Olof
