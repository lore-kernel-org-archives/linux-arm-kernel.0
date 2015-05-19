From: david.vrabel@citrix.com (David Vrabel)
Date: Tue, 19 May 2015 16:27:41 +0100
Subject: [Xen-devel] [RFC 17/23] xen/grant-table: Make it running on 64KB
 granularity
In-Reply-To: <1431622863-28575-18-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <1431622863-28575-18-git-send-email-julien.grall@citrix.com>
Message-ID: <555B566D.8090805@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/15 18:00, Julien Grall wrote:
> The Xen interface is using 4KB page granularity. This means that each
> grant is 4KB.
> 
> The current implementation allocates a Linux page per grant. On Linux
> using 64KB page granularity, only the first 4KB of the page will be
> used.
> 
> We could decrease the memory wasted by sharing the page with multiple
> grant. It will require some care with the {Set,Clear}ForeignPage macro.
> 
> Note that no changes has been made in the x86 code because both Linux
> and Xen will only use 4KB page granularity.

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

David
