From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Feb 2015 13:31:51 +0100
Subject: [PATCH v5 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <20150205120829.GO8656@n2100.arm.linux.org.uk>
References: <1422955310-6542-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <CAJe_Zhf_WuRK2EE0Sj9ksXDDe5VA=DJ+H3eS4YRKpDZLdRRfow@mail.gmail.com>
 <20150205120829.GO8656@n2100.arm.linux.org.uk>
Message-ID: <5765997.dBPa4LUUq1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 February 2015 12:08:29 Russell King - ARM Linux wrote:
> On Thu, Feb 05, 2015 at 05:32:39PM +0530, Jassi Brar wrote:
> > On Feb 5, 2015 5:13 PM, "Arnd Bergmann" <arnd@arndb.de> wrote:
> > >
> > > >
> > > > I know typedef's are frowned upon, but how bad is the following option?
> > > >        typedef void*  mbox_data_info
> > > >        int mbox_send_message(struct mbox_chan *chan, mbox_data_info
> > data);
> > >
> > > I don't see how that would help.
> > >
> > If it's abuse because the argument is a void*... What if we called it
> > mbox_data_info?  To say platforms are free to pass data as a pointer or a
> > value 

I misunderstood then, I thought you were trying to enforce that
people use a proper pointer.

> Using a typedef really doesn't change anything.  If you read the kernel
> coding style, you'll realise that typedefs are a reason to reject
> patches - especially to use them in the way you are proposing.

Agreed, using a typedef here would add an extra problem rather than
solve the one we already have.

> Try the solution I suggested (which I notice was seemingly totally
> ignored.)

As I understood, Jassi doesn't even have this problem, because his
driver uses a synchronous call rather than an asynchronous one
and he can just pass the data on the stack.

	Arnd
