From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 May 2012 11:22:58 +0100
Subject: [PATCH V2] dmaengine/amba-pl08x: check slave_channels to avoid
 kernel panic
In-Reply-To: <CAKwPUoyYaXk3DjY8WGHZtM8j3CB2q94RQvEhD-b6FEP5W+7KFQ@mail.gmail.com>
References: <CAKwPUoyYaXk3DjY8WGHZtM8j3CB2q94RQvEhD-b6FEP5W+7KFQ@mail.gmail.com>
Message-ID: <20120515102258.GI10453@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 06:19:36PM +0800, Kassey Lee wrote:
> commit 58baed44d52f5e0d87aca575318d71fe3937544c
> Author: Kassey Lee <kassey1216@gmail.com>
> Date:   Wed Apr 11 02:22:26 2012 +0800
> 
>     dmaengine/amba-pl08x: check slave_channels to avoid kernel panic
> 
>     slave_channels is platform dependent, it should
>     be initialized by board.c, and here we need to check it
>     to avoid a NULL panic.
> 
>     Signed-off-by: Kassey,Lee <kassey1216@gmail.com>

Why would you set pd->num_slave_channels nonzero but leave
pd->slave_channels as a NULL pointer?

That sounds like a configuration error to me.
