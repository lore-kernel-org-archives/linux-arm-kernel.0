From: joel@joelfernandes.org (Joel Fernandes)
Date: Fri, 19 Oct 2018 22:25:35 -0700
Subject: [PATCH 0/6] Tracing register accesses with pstore and dynamic
 debug
In-Reply-To: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
Message-ID: <20181020052535.GA155509@joelaf.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 09, 2018 at 01:57:01AM +0530, Sai Prakash Ranjan wrote:
> Hi,
> 
> This patch series adds Event tracing support to pstore and is continuation
> to the RFC patch introduced to add a new tracing facility for register
> accesses called Register Trace Buffer(RTB). Since we decided to not introduce
> a separate framework to trace register accesses and use existing framework
> like tracepoints, I have moved from RFC. Details of the RFC in link below:
> 
> Link: https://lore.kernel.org/lkml/cover.1535119710.git.saiprakash.ranjan at codeaurora.org/
> 
> MSR tracing example given by Steven was helpful in using tracepoints for
> register accesses instead of using separate trace. But just having these
> IO traces would not help much unless we could have them in some persistent
> ram buffer for debugging unclocked access or some kind of bus hang or an
> unexpected reset caused by some buggy driver which happens a lot during
> initial development stages. By analyzing the last few entries of this buffer,
> we could identify the register access which is causing the issue.

Hi Sai,

I wanted to see if I could make some time to get your patches working. We are
hitting usecases that need something like this as well. Basically devices
hanging and then the ramdump does not tell us much, so in this case pstore
events can be really helpful. This usecase came up last year as well.

Anyway while I was going through your patches, I cleaned up some pstore code
as well and I have 3 more patches on top of yours for this clean up. I prefer
we submit the patches together and sync our work together so that there is
least conflict.

Here's my latest tree:
https://github.com/joelagnel/linux-kernel/commits/pstore-events
(note that I have only build tested the patches since I just wrote them and
its quite late in the night here ;-))

thanks,

- Joel
