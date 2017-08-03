From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 3 Aug 2017 00:08:36 -0700
Subject: [PATCH] soc: imx: gpcv2: fix regulator deferred probe
In-Reply-To: <20170802195129.20442-1-stefan@agner.ch>
References: <20170802195129.20442-1-stefan@agner.ch>
Message-ID: <CAHQ1cqFyMrSzZCnMfACKTiOi_6k6pprw0G+gRHxWXrvNWvF2kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 2, 2017 at 12:51 PM, Stefan Agner <stefan@agner.ch> wrote:
> If a regulator requests a deferred probe, the power domain gets
> initialized twice. This leads to a list double add (without
> list debugging the kernel hangs due to the double add later):
>
>   WARNING: CPU: 0 PID: 19 at lib/list_debug.c:31 __list_add_valid+0xbc/0xc4
>   list_add double add: new=c1229754, prev=c12383b4, next=c1229754.
>
> Initialize the power domain after we get the regulator. Also do
> not print an error in case the regulator defers probing.
>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Fixes: 03aa12629fc4 ("soc: imx: Add GPCv2 power gating driver")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

As the author of original bug:

Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>

I also went ahead and tested PCIe on my SabreSD with Intel Gigabit adapter, so

Tested-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Thanks for debugging and fixing this!

Andrey Smirnov
