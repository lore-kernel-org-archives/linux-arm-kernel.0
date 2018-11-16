From: eric@anholt.net (Eric Anholt)
Date: Fri, 16 Nov 2018 13:26:12 -0800
Subject: [PATCH v3] firmware: raspberrypi: Fix firmware calls with large
 buffers
In-Reply-To: <20181116143907.6149-1-james.hughes@raspberrypi.org>
References: <20181116143907.6149-1-james.hughes@raspberrypi.org>
Message-ID: <877ehcd897.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

James Hughes <james.hughes@raspberrypi.org> writes:

> Commit a1547e0bca51 ("firmware: raspberrypi: Remove VLA usage")
> moved away from VLA's to a fixed maximum size for mailbox data.
> However, some mailbox calls use larger data buffers
> than the maximum allowed in that change. This fix therefor
> moves from using fixed buffers to kmalloc to ensure all sizes
> are catered for.
>
> There is some documentation, which is somewhat out of date,
> on the mailbox calls here :
> https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
>
> Fixes: a1547e0bca51 ("firmware: raspberrypi: Remove VLA usage")
>
> Signed-off-by: James Hughes <james.hughes@raspberrypi.org>

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181116/4e4c1a16/attachment.sig>
