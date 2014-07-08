From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 8 Jul 2014 20:40:24 -0300
Subject: [PATCH v2 1/3] ethernet: Add new driver for Marvell Armada 375
 network unit
In-Reply-To: <20140708.152655.619472955292197550.davem@davemloft.net>
References: <1404561288-11720-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1404561288-11720-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140708.152655.619472955292197550.davem@davemloft.net>
Message-ID: <20140708234024.GA28830@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08 Jul 03:26 PM, David Miller wrote:
> From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Date: Sat,  5 Jul 2014 08:54:46 -0300
> 
> > +module_param(rxq_number, int, S_IRUGO);
> > +module_param(txq_number, int, S_IRUGO);
> 
> Please don't use module parameters (undocumented ones at that) for things
> like this.
> 
> Instead, use or create standard interfaces which other drivers can use as
> well, so that the user interface is consistent for setting things of this
> nature regardless of device type.
> 

Hm... in fact these two parameters should be removed. They are redundant in
this and the mvneta driver. The Rx queue number should be fixed and none of
the drivers support more than 1.

The Tx queue number should be set to the hardware supported one, there's no
reason to use something different.

So, unless someone objects, we'll remove them in v4.

Thanks for the feedback,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
