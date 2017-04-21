From: slash.tmp@free.fr (Mason)
Date: Fri, 21 Apr 2017 13:27:27 +0200
Subject: linux-next: build failure after merge of the arm tree
In-Reply-To: <9858a4ed-bdd9-bd6c-d8a4-e9e6bd539904@free.fr>
References: <20170421084033.5c987e13@canb.auug.org.au>
 <9858a4ed-bdd9-bd6c-d8a4-e9e6bd539904@free.fr>
Message-ID: <935aedd3-b80e-dd2a-150e-84af1115539d@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/04/2017 09:58, Mason wrote:

> Weird that I didn't catch this when I ran make allyesconfig.

Doh! make allyesconfig builds for BE systems.

CONFIG_CPU_BIG_ENDIAN=y
CONFIG_CPU_ENDIAN_BE8=y

But the patch I originally tested with only updated the LE bitops.

With the complete patch, I didn't see any build issues, other than
drivers/dma/sun4i-dma.c

Regards.
