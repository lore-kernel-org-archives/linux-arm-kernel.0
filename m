From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jan 2013 11:15:26 +0000
Subject: [PATCH] ARM:common: setting saved_state to NULL after kfree
In-Reply-To: <5107AE6F.3080206@asianux.com>
References: <5107AE6F.3080206@asianux.com>
Message-ID: <20130129111526.GQ23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 07:11:43PM +0800, Chen Gang wrote:
>   need set NULL before return, just like function sa1111_remove has done.
>   and better to use sa1111_remove directly, instead of current implementation.

NAK.

1. __sa1111_remove() will kfree sachip, so the value of sachip->saved_state
   at this point is meaningless.
2. I don't think you tried to build with your patch in place.
