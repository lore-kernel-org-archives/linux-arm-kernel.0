From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Jul 2014 18:41:25 +0100
Subject: arm64: More than 16 stream ids
In-Reply-To: <53DA7E9E.7000501@amd.com>
References: <53DA7E9E.7000501@amd.com>
Message-ID: <20140731174125.GH26853@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding the other Rob ;)]

On Thu, Jul 31, 2014 at 06:36:30PM +0100, Joel Schopp wrote:
> I recently ran into a situation where I needed more than 16 stream ids for
> an smmu, but we are currently limited to 16 by:
> 
> #define MAX_MASTER_STREAMIDS        MAX_PHANDLE_ARGS
> #define MAX_PHANDLE_ARGS 16
> 
> I changed that 16 to 32 and everything worked for me.  I am wondering if
> this is the preferred way to fix the limitation?  If so I'd be happy to
> send out the 1 line patch.

This seems fine to me. Last time it was brought up, the objection from RobH
was that there wasn't any upstream activity for the AMD board, so this
change could wait:

  http://lists.linuxfoundation.org/pipermail/iommu/2014-January/007556.html

Will
