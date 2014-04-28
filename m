From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 28 Apr 2014 18:40:54 +0100
Subject: [PATCH 1/3] driver core & of: Mark of_nodes of added device as
 populated
In-Reply-To: <52FA5EB4.7080008@codeaurora.org>
References: <1392137610-27842-1-git-send-email-pawel.moll@arm.com>
 <1392137610-27842-2-git-send-email-pawel.moll@arm.com>
 <52FA5EB4.7080008@codeaurora.org>
Message-ID: <1398706854.20390.8.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-02-11 at 12:32 -0500, Christopher Covington wrote:
> Hi Pawel,
> 
> On 02/11/2014 11:53 AM, Pawel Moll wrote:
> > This patch tries to solve that issue in a generic way,
> > adding a "populated" flag which is set in the device_node
> > structure when a device is being created in the core.
> > Later, of_platform_populate() skips such nodes (and
> > its children) in a similar way to the non-available ones.
> 
> Will there never be a case where it is useful for a parent node to be created
> early, but not necessarily the child nodes? Might only skipping nodes
> explicitly marked as populated be a more universal solution?

That's a good point. I've assumed one would either use
of_platform_device_create() on leaf nodes only (or
of_platform_populate() on subtree), and kept this approach in the
refreshed patch I'm about to post, but I'm happy to do what you
suggested.

Thanks!

Pawel
