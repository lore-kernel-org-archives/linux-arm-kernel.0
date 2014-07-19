From: rostedt@goodmis.org (Steven Rostedt)
Date: Sat, 19 Jul 2014 16:28:10 -0400
Subject: [PATCH 2/4] ARM: add IPI tracepoints
In-Reply-To: <CAKv+Gu_71vJFf3aUZso1X7m7fULUMhxj+MZVYq+LGNRLJvGyAA@mail.gmail.com>
References: <1405660735-13408-1-git-send-email-nicolas.pitre@linaro.org>
 <1405660735-13408-3-git-send-email-nicolas.pitre@linaro.org>
 <20140718160418.54d11f6a@gandalf.local.home>
 <alpine.LFD.2.11.1407181652080.3647@knanqh.ubzr>
 <20140718172221.6dbe83e4@gandalf.local.home>
 <CAKv+Gu_71vJFf3aUZso1X7m7fULUMhxj+MZVYq+LGNRLJvGyAA@mail.gmail.com>
Message-ID: <20140719162810.02285fc8@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 19 Jul 2014 21:10:37 +0200
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 18 July 2014 23:22, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Fri, 18 Jul 2014 16:55:42 -0400 (EDT)
> > Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >
> >>
> >> Here's the patch I have at the head of the series now, with the above
> >> ugliness changed to an unconditional __tracepoint_string attribute.
> >>
> >
> > I was thinking of something like this. Feel free to add this to your
> > series.
> >
> > -- Steve
> >
> 
> Nico,
> 
> If this patch addresses the issue where 3 RCU related tracepoint
> strings turn up /after/ _edata on !CONFIG_TRACING, there is already a
> patch queued up here
> 
> http://marc.info/?l=linux-kernel&m=140518452623148&w=2
> 
> As far as In know, these were the only occurrences using a __used
> modifier, which is why they weren't dropped by the compiler in the
> !CONFIG_TRACING case.
> 

Ard,

Similar but different problem. Nicolas's problem was with new use cases
for tracepoint_string. My patch fixes the issue for the general case.

-- Steve
