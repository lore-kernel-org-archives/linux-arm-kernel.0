From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 25 Nov 2014 12:00:44 -0500 (EST)
Subject: [PATCH 3/9] ARM: MB86S7X: Add MCPM support
In-Reply-To: <CAAfg0W7Y=gpU_LcmSB4LW7ULnWzKPoniaPJguZuNvDzYZ6NH+A@mail.gmail.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1416486920-25343-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <54746C74.8020400@arm.com>
 <CAAfg0W4ntf+yRZnipO+w7beN+EsZcryXCuD1eUJo1RYQNkJ2hQ@mail.gmail.com>
 <54749116.2050307@arm.com>
 <CAAfg0W7Y=gpU_LcmSB4LW7ULnWzKPoniaPJguZuNvDzYZ6NH+A@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1411251148390.11690@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Nov 2014, Andy Green wrote:

> On 25 November 2014 at 22:24, Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
> > So IIUC, you run Linux in non-secure mode, PSCI would be more suitable
> > than MCPM when you start thinking/implementing CPUIdle otherwise I think
> > you will end up duplicating some logic(last man and race management)
> > both in Linux as well as your secure firmware.
> 
> As I mentioned our secure firmware is not what you're imagining.
> 
> MCPM works very well for us.  Are you saying we can't use MCPM and
> must reimplement with PSCI on both sides?

I said it many times before: not everyone is willing to invest in the 
complexity trap implied by the firmware model as proposed by ARM.  This 
is a concrete example of that.  MCPM-like functionality is an order of 
magnitude simpler to debug and maintain when implemented on the 
easily-replaceable kernel side.


Nicolas
