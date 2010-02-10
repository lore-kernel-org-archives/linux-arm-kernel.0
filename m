From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 10 Feb 2010 08:54:26 -0700
Subject: [PATCH] async-tx: fix buffer sumbission error handling in
	ipu_idma.c
In-Reply-To: <Pine.LNX.4.64.1002101643390.4495@axis700.grange>
References: <Pine.LNX.4.64.1002101643390.4495@axis700.grange>
Message-ID: <e9c3a7c21002100754k7737b79cvb13a2b39ad16cc44@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2010 at 8:44 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> If submitting new buffer failed, a wrong descriptor gets completed and it
> doesn't check, if a callback is at all defined, which can lead to an Oops. Fix
> these bugs and make ipu_update_channel_buffer() void, because it never fails.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Looks like 2.6.33 material.  Shall I tag it for -stable as well?

--
Dan
