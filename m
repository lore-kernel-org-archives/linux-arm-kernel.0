From: eric@anholt.net (Eric Anholt)
Date: Tue, 01 Nov 2016 09:38:45 -0700
Subject: [PATCH] staging: vc04_services: parse_rx_slots() - Fix compiler
 warning
In-Reply-To: <20161101152114.19394-1-mzoran@crowfest.net>
References: <20161101152114.19394-1-mzoran@crowfest.net>
Message-ID: <87k2cni296.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Zoran <mzoran@crowfest.net> writes:

> vc04_services contains a debug logging mechanism.  The log is
> maintained in a shared memory area between the kernel and the
> firmware.  Changing the sizes of the data in this area would
> require a firmware change which is distributed independently
> from the kernel binary.
>
> One of the items logged is the address of received messages.
> This address is a pointer, but the debugging slot used to store
> the information is a 32 bit integer.
>
> Luckily, this value is never interpreted by anything other
> then debug tools and it is expected that a human debugging
> the kernel interpret it.
>
> This change adds a cast to long before the original cast
> to int to silence the warning.
>
> Signed-off-by: Michael Zoran <mzoran@crowfest.net>

Thanks for sorting this out.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161101/ee842ff3/attachment.sig>
