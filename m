From: joel.schopp@amd.com (Joel Schopp)
Date: Thu, 31 Jul 2014 12:36:30 -0500
Subject: arm64: More than 16 stream ids
Message-ID: <53DA7E9E.7000501@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I recently ran into a situation where I needed more than 16 stream ids for an smmu, but we are currently limited to 16 by:

#define MAX_MASTER_STREAMIDS        MAX_PHANDLE_ARGS
#define MAX_PHANDLE_ARGS 16

I changed that 16 to 32 and everything worked for me.  I am wondering if this is the preferred way to fix the limitation?  If so I'd be happy to send out the 1 line patch.

-Joel
