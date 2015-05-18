From: davem@davemloft.net (David Miller)
Date: Mon, 18 May 2015 19:52:30 -0400 (EDT)
Subject: [PATCH net-next v3 2/2] net: Adding support for Cavium
 ThunderX network controller
In-Reply-To: <555A5F1E.1010509@caviumnetworks.com>
References: <1431747401-20847-3-git-send-email-aleksey.makarov@auriga.com>
 <20150518.160931.2235555994068443513.davem@davemloft.net>
 <555A5F1E.1010509@caviumnetworks.com>
Message-ID: <20150518.195230.2247842502863025488.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <ddaney@caviumnetworks.com>
Date: Mon, 18 May 2015 14:52:30 -0700

> As I see it there are two options:
> 
> 1) Keep the writeq_relaxed()/readq_relaxed(), but add a comment about
> why they are safe.
> 
> 2) Change the patch so that we are using writeq()/readq() and suffer a
> decrease in performance.

I want a detailed comment added, so #1 would be my choice.

There are more than one set of register accessors, so make sure you
annotate them all.

Thanks.
