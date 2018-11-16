From: valdis.kletnieks@vt.edu (valdis.kletnieks at vt.edu)
Date: Fri, 16 Nov 2018 06:33:08 -0500
Subject: [ARM64] Printing IRQ stack usage information
In-Reply-To: <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com>
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
 <28496.1542300549@turing-police.cc.vt.edu>
 <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com>
Message-ID: <49219.1542367988@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Nov 2018 11:44:36 +0530, Pintu Agarwal said:

> > If your question is "Did one
> > of the CPUs blow out its IRQ stack (or come close to doing so)?" there's better
> > approaches.
> >
> Yes, exactly, this is what the main intention.
> If you have any better idea about this approach, please refer me.
> It will be of great help.

Look at the code controlled by '#ifdef CONFIG_DEBUG_STACK_USAGE'
which does the same thing for process stacks, or CONFIG_SCHED_STACK_END_CHECK
or the use of guard pages for detecting stack overrun....
