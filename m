From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 27 Feb 2017 17:58:26 -0500
Subject: [PATCH] jump_label: align jump_entry table to at least 4-bytes
In-Reply-To: <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
Message-ID: <20170227175826.2ddceec2@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Feb 2017 14:45:37 -0800
David Daney <ddaney@caviumnetworks.com> wrote:

> On 02/27/2017 02:36 PM, Steven Rostedt wrote:
> > On Mon, 27 Feb 2017 14:21:21 -0800
> > David Daney <ddaney@caviumnetworks.com> wrote:
> >  
> >> See attached for mips.  It seems to do the right thing.
> >>
> >> I leave it as an exercise to the reader to fix the other architectures.
> >>
> >> Consult your own  binutils experts to verify that what I say is true.  
> >
> > It may still just be safer to do the pointers instead. That way we
> > don't need to worry about some strange arch or off by one binutils
> > messing it up.  
> 
> Obviously it is your choice, but this is bog standard ELF linking.  In 
> theory even the arrays of power-of-2 sized objects should also supply an 
> entity size.  Think __ex_table and its ilk.
> 
> 
> The benefit of supplying an entsize is that you don't have to change the 
> structure of the existing code and risk breaking something in the process.

I agree that this may be the better answer. The issue tracepoints had
is that they were defined in C with a "section" attribute. I'm not sure
you can pass various section attributes via a gcc section attribute.

-- Steve
