From: daniel@ffwll.ch (Daniel Vetter)
Date: Sun, 27 Apr 2014 14:51:30 +0200
Subject: [RFC PATCH 0/8] component helper improvements
In-Reply-To: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
References: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
Message-ID: <CAKMK7uFE7NVTS8dgb7kmXtAcz2Q59WhxrZJWcktG98UegFW1zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 27, 2014 at 1:00 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> A while back, Laurent raised some comments about the component helper,
> which this patch set starts to address.
>
> The first point it addresses is the repeated parsing inefficiency when
> deferred probing occurs.  When DT is used, the structure of the
> component helper today means that masters end up parsing the device
> tree for each attempt to re-bind the driver.
>
> We remove this inefficiency by creating an array of matching data and
> functions, which the component helper can use internally to match up
> components to their master.
>
> The second point was the inefficiency of destroying the list of
> components each time we saw a failure.  We did this to ensure that
> we kept things correctly ordered: component bind order matters.
> As we have an array instead, the array is already ordered, so we
> use this array to store the component pointers instead of a list,
> and remember which are duplicates (and thus should be avoided.)
> Avoiding the right duplicates matters as we walk the array in the
> opposite direction at tear down.
>
> I would like to see patches 1-5 scheduled for the next merge window,
> with 6-8 for the following window - this gives us grace of one kernel
> cycle to ensure that any new component helper users are properly
> converted.

Afaict the actual patches haven't made it to dri-devel, only to
linux-arm-kernel. Are they stuck somewhere?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
