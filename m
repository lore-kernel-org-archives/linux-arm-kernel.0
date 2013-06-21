From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 21 Jun 2013 17:30:44 +0200
Subject: [PATCH 8/9] iommu: add support for ARM Ltd. System MMU
 architecture
In-Reply-To: <20130621150006.GG7766@mudshark.cambridge.arm.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-9-git-send-email-will.deacon@arm.com>
 <20130620212646.GG11309@8bytes.org>
 <20130621102318.GB7766@mudshark.cambridge.arm.com>
 <20130621141306.GJ11309@8bytes.org>
 <20130621150006.GG7766@mudshark.cambridge.arm.com>
Message-ID: <20130621153044.GL11309@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 04:00:06PM +0100, Will Deacon wrote:
> Damn, I was hoping to avoid locking on the map path. In fact, this is a good
> argument to go with your suggestion below (otherwise I'd need to use
> reader/writer locks which seem to be frowned on).

You should look into using rcu-lists instead. You still need a lock, but
only when you actually manipulating the lists. For traversing them it is
sufficient to take the rcu_read_lock() which has very low overhead.


	Joerg
