From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 19 May 2010 05:45:50 -0600
Subject: Boot interface for device trees on ARM
In-Reply-To: <201005181054.32325.jeremy.kerr@canonical.com>
References: <201005181054.32325.jeremy.kerr@canonical.com>
Message-ID: <AANLkTimIUgIdMUY0WKH4OXpOATtGbW2bgtT0hhF0HujF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 8:54 PM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:
> Hi all,
>
> As we're getting closer to device tree support on ARM, I'd like to get some
> input on our proposed boot interface.
>
> Basically, I'd like to define how we pass the device tree from the bootloader
> to the kernel.
>
> My current method of doing this is through a new atag. It looks like this:
>
> ? ? ? ?/* flattened device tree blob pointer */
> ? ? ? ?#define ATAG_DEVTREE ? ?0x5441000a
>
> ? ? ? ?struct tag_devtree {
> ? ? ? ? ? ? ? ?__u32 start; ? ?/* physical start address */
> ? ? ? ? ? ? ? ?__u32 size; ? ? /* size of dtb image in bytes */
> ? ? ? ?};
>
> With ATAG_DEVTREE, we keep the existing boot interface the same (ie, machine
> number in r1, atags pointer r2).

For the reference of those new to this discussion, here is a link to
the previous thread and the link to the draft boot interface document.

http://www.mail-archive.com/devicetree-discuss at lists.ozlabs.org/msg00884.html
http://devicetree.org/Boot_Environment

[...]

> ?- We are now potentially carrying data in two different places - atags and
> the device tree. For example, the physical memory layout and kernel command
> line may be present in both.

I've tried to explicitly addresses this in the draft document.  the DT
blob always supersedes ATAG information.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
