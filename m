From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Apr 2016 15:21:48 +0100
Subject: [PATCH 1/2] arm64: mem-model: add flatmem model for arm64
In-Reply-To: <1459844572-53069-1-git-send-email-puck.chen@hisilicon.com>
References: <1459844572-53069-1-git-send-email-puck.chen@hisilicon.com>
Message-ID: <20160407142148.GI5657@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2016 at 04:22:51PM +0800, Chen Feng wrote:
> We can reduce the memory allocated at mem-map
> by flatmem.
> 
> currently, the default memory-model in arm64 is
> sparse memory. The mem-map array is not freed in
> this scene. If the physical address is too long,
> it will reserved too much memory for the mem-map
> array.

Can you elaborate a bit more on this, please? We use the vmemmap, so any
spaces between memory banks only burns up virtual space. What exactly is
the problem you're seeing that makes you want to use flatmem (which is
probably unsuitable for the majority of arm64 machines).

Will
