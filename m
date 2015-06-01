From: fransklaver@gmail.com (Frans Klaver)
Date: Mon, 1 Jun 2015 11:14:12 +0200
Subject: [PATCH 05/98] exynos_drm.h: use __u64 from linux/types.h
In-Reply-To: <556C2105.2090607@amd.com>
References: <1433000370-19509-1-git-send-email-mikko.rapeli@iki.fi>
 <1433000370-19509-6-git-send-email-mikko.rapeli@iki.fi>
 <20150530164655.GM2067@n2100.arm.linux.org.uk>
 <556C15BA.7000909@amd.com>
 <20150601085605.GN2067@n2100.arm.linux.org.uk>
 <556C2105.2090607@amd.com>
Message-ID: <CAH6sp9PEuukeGrzXVKmgFZ+CcyfYdT=4VyGQdAGdnhD-chh+sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 1, 2015 at 11:08 AM, Christian K?nig
<christian.koenig@amd.com> wrote:
> Yeah, completely agree with Linus on the visibility problem and that's
> exactly the reason why we don't include <stdint.h> in the kernel header and
> expect userspace to define the ISO types somewhere.
>
> But using the types from "include/linux/types.h" and especially including it
> into the uapi headers doesn't make the situation better, but rather worse.
>
> With this step we not only make the headers depend on another header that
> isn't part of the uapi, but also pollute the user space namespace with __sXX
> and __uXX types which aren't defined anywhere else.

These __uXX and __sXX types are defined in
include/uapi/asm-generic/ll64.h and pulled in by
include/uapi/linux/types.h. Including linux/types.h is therefore
valid.

Frans
