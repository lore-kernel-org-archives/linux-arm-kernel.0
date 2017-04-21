From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Apr 2017 18:12:30 +1000
Subject: linux-next: build failure after merge of the arm tree
In-Reply-To: <9858a4ed-bdd9-bd6c-d8a4-e9e6bd539904@free.fr>
References: <20170421084033.5c987e13@canb.auug.org.au>
 <9858a4ed-bdd9-bd6c-d8a4-e9e6bd539904@free.fr>
Message-ID: <20170421181230.05dcf937@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mason,

On Fri, 21 Apr 2017 09:58:58 +0200 Mason <slash.tmp@free.fr> wrote:
>
> Anyway, the fix is trivial.
> 
> The "pchans_used" field is an unsigned long array.
> for_each_clear_bit_from() expects an unsigned long pointer,
> not an array address.
> 
> I'll send a patch to the drivers/dma maintainers.

The fix really needs to go into the arm tree (as well?) since that is
the tree that has the patch that causes the build to break (even if the
actual bug was preexisting).

-- 
Cheers,
Stephen Rothwell
