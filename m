From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 7 Jun 2013 20:49:03 -0300
Subject: [PATCH] ARM: mach-imx6q: Enable the codec clock earlier
In-Reply-To: <51B27010.5060603@boundarydevices.com>
References: <1370642870-8051-1-git-send-email-festevam@gmail.com>
 <20130607222051.GD18614@n2100.arm.linux.org.uk>
 <CAOMZO5B_PY0p1vqEUiYA88uhzYaOjnr5o9nXeEgLkKpPxD1LRQ@mail.gmail.com>
 <51B27010.5060603@boundarydevices.com>
Message-ID: <CAOMZO5Awh76wRDs+t10H_KgsiA+itRURET+WVUtEqP7H1WaxTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Troy,

On Fri, Jun 7, 2013 at 8:43 PM, Troy Kisky
<troy.kisky@boundarydevices.com> wrote:

> Perhaps a delay is needed after the clock is turned on, to when you can read
> a register.

The problem is that in linux-next the reading of the codec happens
before the clock is turned on and I was not able to understand yet why
this is happening .

On Linus' tree the codec reading only happens after the codec clock is on.

> Using -EPROBE_DEFER seems like an abuse. Shouldn't it turn the clock back
> off before it returns anyway?

That was done just for testing purpose.

Regards,

Fabio Estevam
