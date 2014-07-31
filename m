From: oleg@redhat.com (Oleg Nesterov)
Date: Thu, 31 Jul 2014 18:58:04 +0200
Subject: [PATCH v4 2/5] x86,entry: Only call user_exit if TIF_NOHZ
In-Reply-To: <20140731165423.GA16800@redhat.com>
References: <cover.1406604806.git.luto@amacapital.net>
 <7123b2489cc5d1d5abb7bcf1364ca729cab3e6ca.1406604806.git.luto@amacapital.net>
 <20140729193232.GA8153@redhat.com>
 <20140730164344.GA27954@localhost.localdomain>
 <CALCETrUVaz3JFiNbyU=r3M-E9muHa1ffn7RX+_-4V_0U-hVaPw@mail.gmail.com>
 <20140731151630.GA7842@localhost.localdomain>
 <20140731164246.GA15974@redhat.com>
 <20140731164918.GC7842@localhost.localdomain>
 <20140731165423.GA16800@redhat.com>
Message-ID: <20140731165804.GB16800@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31, Oleg Nesterov wrote:
>
> On 07/31, Frederic Weisbecker wrote:
> >
> > On Thu, Jul 31, 2014 at 06:42:46PM +0200, Oleg Nesterov wrote:
> > >
> > > And if we change this, then the code above becomes racy. The state of
> > > TIF_XYZ can be changed right after the check. OK, it is racy anyway ;)
> > > but still this adds more confusion.
> >
> > No because all running tasks have this flag set when context tracking is
> > enabled. And context tracking can't be disabled on runtime.
>
> Yes, yes, please note that I said "if we change this".

And "it is racy anyway" connects to the problems we discuss in another
thread.

Oleg.
