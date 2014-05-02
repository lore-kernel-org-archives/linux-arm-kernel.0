From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 2 May 2014 15:02:06 -0400
Subject: [PATCH v8 1/8] ftrace: make CALLER_ADDRx macros more generic
In-Reply-To: <20140502181348.GD14645@arm.com>
References: <1394862048-28758-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-2-git-send-email-takahiro.akashi@linaro.org>
 <20140502181348.GD14645@arm.com>
Message-ID: <20140502150206.4afa9b1a@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 May 2014 19:13:48 +0100
Will Deacon <will.deacon@arm.com> wrote:

> Hi Akashi,
> 
> On Wed, Apr 30, 2014 at 10:54:29AM +0100, AKASHI Takahiro wrote:
> > Most archs with HAVE_ARCH_CALLER_ADDR have the almost same definitions
> > of CALLER_ADDRx(n), and so put them into linux/ftrace.h.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  arch/arm/include/asm/ftrace.h      |   10 +---------
> >  arch/blackfin/include/asm/ftrace.h |   11 +----------
> >  arch/parisc/include/asm/ftrace.h   |   10 +---------
> >  arch/sh/include/asm/ftrace.h       |   10 +---------
> >  arch/xtensa/include/asm/ftrace.h   |   14 ++++----------
> >  include/linux/ftrace.h             |   34 ++++++++++++++++++----------------
> >  6 files changed, 26 insertions(+), 63 deletions(-)
> 
> This one looks a bit too widespread to be merged via the arm64 tree. I
> wonder if the ftrace maintainers would consider taking it as a cleanup?
> 

I actually was the one to recommend this approach. But I have some
small comments to the patch. I'll reply directly to the patch with them.

-- Steve
