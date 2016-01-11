From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 11 Jan 2016 11:24:26 +0100
Subject: [PATCH 1/1] USB: core: let USB device know device node
In-Reply-To: <20160111095747.GA9239@shlinux2>
References: <1452501535-8580-1-git-send-email-peter.chen@freescale.com>
 <201601111658.gmkaFolV%fengguang.wu@intel.com>
 <20160111095747.GA9239@shlinux2>
Message-ID: <20160111102426.GN13058@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 05:57:47PM +0800, Peter Chen wrote:
> On Mon, Jan 11, 2016 at 04:54:21PM +0800, kbuild test robot wrote:
> > Hi Peter,
> > 
> > [auto build test ERROR on usb/usb-testing]
> > [also build test ERROR on v4.4 next-20160108]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Peter-Chen/USB-core-let-USB-device-know-device-node/20160111-164533
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > config: x86_64-randconfig-x002-201602 (attached as .config)
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64 
> > 
> > All error/warnings (new ones prefixed by >>):
> > 
> >    In file included from include/linux/compiler.h:56:0,
> >                     from include/uapi/linux/stddef.h:1,
> >                     from include/linux/stddef.h:4,
> >                     from include/uapi/linux/posix_types.h:4,
> >                     from include/uapi/linux/types.h:13,
> >                     from include/linux/types.h:5,
> >                     from include/linux/list.h:4,
> >                     from include/linux/module.h:9,
> >                     from drivers/usb/core/usb.c:24:
> > >> include/linux/compiler-gcc.h:73:17: error: expected '{' before 'inline'
> >     #define inline  inline  __attribute__((always_inline)) notrace
> >                     ^
> > >> include/linux/usb/of.h:36:8: note: in expansion of macro 'inline'
> >     struct inline device_node * usb_of_get_child_node(struct device_node *parent,
> >            ^
> 
> Would anybody explain what does above mean, thanks.
> I just can't reproduce it at my env.

The instructions to reproduce this is included in the kbuild test robot mail.

Here you have to compile with CONFIG_OF disabled.

struct inline device_node * usb_of_get_child_node(...)

should be:

static inline struct device_node *usb_of_get_child_node(...)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
