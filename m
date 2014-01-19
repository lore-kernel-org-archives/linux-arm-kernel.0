From: tj@kernel.org (Tejun Heo)
Date: Sun, 19 Jan 2014 14:22:42 -0500
Subject: [RFC v3 08/13] ahci-platform: Allow specifying platform_data
 through of_device_id
In-Reply-To: <52DC1FF5.80101@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-9-git-send-email-hdegoede@redhat.com>
 <20140119113838.GE11123@htj.dyndns.org> <52DC1FF5.80101@redhat.com>
Message-ID: <20140119192242.GD32165@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 07:56:53PM +0100, Hans de Goede wrote:
> 1) of_match_device returns const, so without the const the code would need
> to cast that const away somewhere
> 2) of_match_device is right to return const because
> 2a) the data can actually be const
> 2b) even if not const, it is shared between multiple instances of the same
> device-type and thus should never be written too

Sure, if it has already gone that way, keeping it on is probably the
easiest way.

> So as Russell already said, the use of const is correct here, and the best
> thing to do is to simply keep it.

It's not about whether this specific annotation is correct or not.
It's that C as a language doesn't have good enough const support to
have proper const annotations and tends to lead to practical problems
often making the trade-off unclear in complex cases.

Anyways, as written above, if it's propagation of existing ones and
doesn't have mixed ro/rw usages, keeping it on probably is the eaiest.

Thanks.

-- 
tejun
