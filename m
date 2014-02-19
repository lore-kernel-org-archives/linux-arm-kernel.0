From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Feb 2014 17:06:10 +0100
Subject: [PATCH v4 02/13] ARM: mvebu: remove the address parameter for
 ll_set_cpu_coherent
In-Reply-To: <1392312816-17657-3-git-send-email-gregory.clement@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
 <1392312816-17657-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140219170610.779573a2@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

On Thu, 13 Feb 2014 18:33:25 +0100, Gregory CLEMENT wrote:
> Until now the calling functions of ll_set_cpu_coherent() have to know
> the base address of the coherency registers. This commit doesn't
> expose anymore this address. This was needed to be able to use either
> a virtual or a physical address. This patch add a check of the MMU bit
> to choose the accurate address, then the calling function do have pass
> this information.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

I think your commit log needs some review:

I don't understand "This commit doesn't expose anymore this address."
from your commit log. Do you mean that the address is no longer passed
as argument to ll_set_cpu_coherent() ?

Similarly, the sentence "This patch add a check of the MMU bit to choose
the accurate address, then the calling function do have pass this
information." seems incorrect, as the commit does quite the opposite:
the calling function do *NOT* have to pass the base address of the
coherency.

Finally, your commit log doesn't explain *why* this change is
necessary. At first sight, switching from using a function argument to
a global variable looks like a step in the wrong direction. An
explanation as to why this is the right direction seems needed here.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
