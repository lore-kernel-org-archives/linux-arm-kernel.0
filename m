From: davem@davemloft.net (David Miller)
Date: Fri, 23 Mar 2018 13:16:56 -0400 (EDT)
Subject: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <b4553d26-b326-15be-dcac-12594ea7c5b5@codeaurora.org>
References: <4bd9ccd2-df8f-acad-2513-eefe065dc852@codeaurora.org>
 <20180323.130418.2223623186761161723.davem@davemloft.net>
 <b4553d26-b326-15be-dcac-12594ea7c5b5@codeaurora.org>
Message-ID: <20180323.131656.2151525994998240049.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 23 Mar 2018 13:13:46 -0400

> We have decided to drop a similar patch on Infiniband due to incorrect
> usage of barrier(). If you feel strongly about it, I can remove the
> DOORBELL change.

Either remove the DOORBELL change or properly adjust the barrier() to
be a wmb().

Be sure to mention this in the commit message, explicitly.

Thank you.
