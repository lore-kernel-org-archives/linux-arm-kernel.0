From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 14 Jul 2017 16:09:55 +0300
Subject: [PATCH 14/14] [media] fix warning on v4l2_subdev_call() result
 interpreted as bool
In-Reply-To: <20170714125525.kjemhcn4poon6r3i@mwanda>
References: <20170714092540.1217397-1-arnd@arndb.de>
 <20170714093938.1469319-1-arnd@arndb.de>
 <20170714120512.ioe67nnloqivtbr7@mwanda>
 <CAK8P3a0f84OPcCK1r3P9inGYDJC2KaAO4mjE2vn+vCws-oo_bw@mail.gmail.com>
 <20170714125525.kjemhcn4poon6r3i@mwanda>
Message-ID: <20170714130955.zqe26g6zpixr3xj2@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 03:55:26PM +0300, Dan Carpenter wrote:
> I don't agree with it as a static analysis dev...

What I mean is if it's a macro that returns -ENODEV or a function that
returns -ENODEV, they should both be treated the same.  The other
warnings this check prints are quite clever.

regards,
dan carpenter
