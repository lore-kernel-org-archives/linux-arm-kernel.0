From: changbin.du@gmail.com (Changbin Du)
Date: Sat, 10 Nov 2018 09:41:12 +0800
Subject: [PATCH v3 1/4] x86/mm: declare check_la57_support() as inline
In-Reply-To: <CAK7LNAQcdpU+_LOYQ8X+4K4sxd3D-+Z7k6BuBjUOJ9LR0j+zfA@mail.gmail.com>
References: <20181028130945.23581-1-changbin.du@gmail.com>
 <20181028130945.23581-2-changbin.du@gmail.com>
 <20181028140911.21d49629@vmware.local.home>
 <CAK7LNATixykqHqdu5W3NpfXqBXMNsP0OLKjNdsFc_EzJ_diOxA@mail.gmail.com>
 <20181102112728.GC14602@zn.tnic>
 <CAK7LNAQcdpU+_LOYQ8X+4K4sxd3D-+Z7k6BuBjUOJ9LR0j+zfA@mail.gmail.com>
Message-ID: <20181110010708.d3nayrzuy5d3lrkd@mail.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2018 at 01:27:29AM +0900, Masahiro Yamada wrote:
> On Fri, Nov 2, 2018 at 8:28 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Oct 29, 2018 at 10:04:46PM +0900, Masahiro Yamada wrote:
> > > On Mon, Oct 29, 2018 at 3:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > On Sun, 28 Oct 2018 13:09:42 +0000
> > > > Changbin Du <changbin.du@gmail.com> wrote:
> > > >
> > > > > The level4_kernel_pgt is only defined when X86_5LEVEL is enabled.
> > > > > So declare check_la57_support() as inline to make sure the code
> > > > > referring to level4_kernel_pgt is optimized out. This is a preparation
> > > > > for CONFIG_CC_OPTIMIZE_FOR_DEBUGGING.
> > > > >
> > > > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > > >
> > > > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > >
> > > > -- Steve
> > > >
> > >
> > > Applied to linux-kbuild.
> >
> > Next time, before you route a patch through your tree, please get an x86
> > maintainer's ACK first.
> 
> 
> I changed my mind, and did not include this in my previous pull request
> because this series is causing many warnings.
>
Most of the new warnings are false warnings. Since this series didn't change any
code where the warnings happen. I'll make patches to make gcc happy.

> Now, it is aiming for v5.0-rc1
> 
> So, it is not too late.
> 
> If x86 maintainers issue Acked-by,
> I am happy to add it.
> 
> 
> 
> 
> > Thx.
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > Good mailing practices for 400: avoid top-posting and trim the reply.
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
Thanks,
Changbin Du
