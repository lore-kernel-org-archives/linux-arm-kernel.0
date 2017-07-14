From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Jul 2017 21:32:25 +0200
Subject: [PATCH 14/14] [media] fix warning on v4l2_subdev_call() result
 interpreted as bool
In-Reply-To: <20170714130955.zqe26g6zpixr3xj2@mwanda>
References: <20170714092540.1217397-1-arnd@arndb.de>
 <20170714093938.1469319-1-arnd@arndb.de>
 <20170714120512.ioe67nnloqivtbr7@mwanda>
 <CAK8P3a0f84OPcCK1r3P9inGYDJC2KaAO4mjE2vn+vCws-oo_bw@mail.gmail.com>
 <20170714125525.kjemhcn4poon6r3i@mwanda>
 <20170714130955.zqe26g6zpixr3xj2@mwanda>
Message-ID: <CAK8P3a1ckDk2VEhK9EWXU7ZWqh1UoZVMac9j3-1KGioj8EE+kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 3:09 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Fri, Jul 14, 2017 at 03:55:26PM +0300, Dan Carpenter wrote:
>> I don't agree with it as a static analysis dev...
>
> What I mean is if it's a macro that returns -ENODEV or a function that
> returns -ENODEV, they should both be treated the same.  The other
> warnings this check prints are quite clever.

I think this is what gcc tries to do, and it should work normally, but it
fails when using ccache. I know I had cases like that, not entirely sure
if this is one of them. Maybe it just means I should give up on using
ccache in preprocessor mode.

       Arnd
