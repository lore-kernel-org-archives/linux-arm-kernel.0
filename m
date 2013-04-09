From: linfeng@cn.fujitsu.com (Lin Feng)
Date: Tue, 09 Apr 2013 10:07:11 +0800
Subject: [PATCH 2/2] mm: vmemmap: arm64: add vmemmap_verify check for
 hot-add node case
In-Reply-To: <20130408105556.GB17476@mudshark.cambridge.arm.com>
References: <1365415000-10389-1-git-send-email-linfeng@cn.fujitsu.com>
 <1365415000-10389-3-git-send-email-linfeng@cn.fujitsu.com>
 <20130408105556.GB17476@mudshark.cambridge.arm.com>
Message-ID: <516377CF.2080004@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi will,

On 04/08/2013 06:55 PM, Will Deacon wrote:
> Given that we don't have NUMA support or memory-hotplug on arm64 yet, I'm
> not sure that this change makes much sense at the moment. early_pfn_to_nid
> will always return 0 and we only ever have one node.
> 
> To be honest, I'm not sure what that vmemmap_verify check is trying to
> achieve anyway. ia64 does some funky node affinity initialisation early on
> but, for the rest of us, it looks like we always just check the distance
> from node 0.

Sorry for my noise to arm people.

Yes, not everyone cares about vmemmap_verify(), as you described it's not
necessary to arm64 at all. 

thanks,
linfeng
