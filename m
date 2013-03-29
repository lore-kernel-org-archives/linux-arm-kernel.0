From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 29 Mar 2013 19:53:18 +0800
Subject: [PATCH] arm: prima2: export sirfsoc_reset_device as the common
 API of drivers
In-Reply-To: <201303281724.14385.arnd@arndb.de>
References: <1364353599-30731-1-git-send-email-Barry.Song@csr.com>
 <201303281724.14385.arnd@arndb.de>
Message-ID: <CAGsJ_4zkAd_qiNrv7n7vZ8YugdrqcOCQWeANWqkP28KCLKNV6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/29 Arnd Bergmann <arnd@arndb.de>
>
> On Wednesday 27 March 2013, Barry Song wrote:
> > From: "renwei.wu" <renwei.wu@csr.com>
> >
> > sirfsoc_reset_device() should be an API used by other SiRF drivers.
> > This patch exports it.
> > devices who want to reset just need to add reset_bit in .dts.
> >
> > Signed-off-by: Renwei Wu <Renwei.Wu@csr.com>
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> The interface is currently not used in the mainline kernel, and
> having a global header for it is not a good solution in the long
> run. Please have a look at the patches labeled "Reset controller
> API to reset IP modules on i.MX5 and i.MX6" from Philipp Zabel
> and coordinate with him or base your own drivers on his code
> when you get it upstream.

well. happy to see there is another subsystem about reset_controller.
that should remove the requirement of sirfsoc specific reset api.

>
>         Arnd

-barry
