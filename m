From: tj@kernel.org (Tejun Heo)
Date: Sun, 19 Jan 2014 08:19:10 -0500
Subject: [RFC v3 08/13] ahci-platform: Allow specifying platform_data
 through of_device_id
In-Reply-To: <20140119123055.GO15937@n2100.arm.linux.org.uk>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-9-git-send-email-hdegoede@redhat.com>
 <20140119113838.GE11123@htj.dyndns.org>
 <20140119123055.GO15937@n2100.arm.linux.org.uk>
Message-ID: <20140119131910.GF11123@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 12:30:55PM +0000, Russell King - ARM Linux wrote:
> I don't see anything wrong with this.  Platform data should _never_ be
> written to, because doing so will change the driver behaviour between
> bindings.  It really should be read-only to driver code.

Hmmm, problems usually arise when const is used to distinguish ro and
rw users.  When it's simple, it seems okay but later on it often ends
up requiring dropping const in almost arbitrary places or forced casts
somewhere random.  Over time, it makes const annotations in the kernel
sparse and inconsistent.  For anything non-trivial, I think it's best
to ignore it.

That said, if the object is actually immutable once initialized, it
shouldn't cause any trouble.  That probably is one of the few proper
use case for const on complex data types.

Thanks.

-- 
tejun
