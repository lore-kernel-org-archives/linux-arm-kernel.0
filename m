From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 18 Oct 2009 15:28:40 +0800
Subject: [PATCH] pxa: extend gpio pins from 128 to 256
In-Reply-To: <771cded00910172343s525e527flc4e06582b9951e47@mail.gmail.com>
References: <771cded00909250339g1b894557v6cabf978fa11e470@mail.gmail.com>
	<f17812d70910150401q425b47e2hb4da64bb203dc770@mail.gmail.com>
	<771cded00910172201k6cf7c8c7ue7485c4c876e8123@mail.gmail.com>
	<f17812d70910172303l6cf6693bxabb2fed121cd33f4@mail.gmail.com>
	<771cded00910172343s525e527flc4e06582b9951e47@mail.gmail.com>
Message-ID: <f17812d70910180028y12ba79a9vd576cd832b5ae190@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mmm... as long as the platforms call pxa2xx_mfp_config(), I was thinking the
pxa2xx part can remain intact, saving some bits.

Soon will be on the flight, will reply two days later. Thanks.

On Oct 18, 2009 2:43 PM, "Haojian Zhuang" <haojian.zhuang@gmail.com> wrote:

On Sun, Oct 18, 2009 at 2:03 AM, Eric Miao <eric.y.miao@gmail.com> wrote: >
On Sun, Oct 18, 2009 at ...
I think that mfp_to_gpio() macro is also a part of mfp driver. This
macro is used widely
in platform driver in order to allocate platform irq resource.
NR_BUILTIN_GPIO is similar
to this macro.

Because they're used in structure initialization, we can't use
detecting CPU method to
distinguish how much mfp/gpio pins can be applied on current CPU.
Since we couldn't
import variable or function into structure intialization code. Current
patch is the easiest
modification.

If there's a better solution, I'm glad to adopt it. :)

Thanks
Haojian
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091018/a1d31678/attachment-0001.htm>
