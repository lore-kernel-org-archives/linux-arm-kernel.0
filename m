From: mturquette@linaro.org (Michael Turquette)
Date: Thu, 23 Jul 2015 17:00:01 -0700
Subject: [PATCH v2 1/7] clk: Add a basic factor clock
In-Reply-To: <20150523074930.GI8557@lukather>
References: <1432241646-9511-1-git-send-email-maxime.ripard@free-electrons.com>
 <1432241646-9511-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64rqRC24wPWz5xYZv=w2QAtsCb-pd76Qynkb5NBCptXhQ@mail.gmail.com>
 <20150523074930.GI8557@lukather>
Message-ID: <20150724000001.642.84690@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2015-05-23 00:49:30)
> On Fri, May 22, 2015 at 12:35:35PM +0800, Chen-Yu Tsai wrote:
> > Hi,
> > 
> > On Fri, May 22, 2015 at 4:54 AM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> > > Some clocks are using a factor component, however, unlike their mux, gate
> > > or divider counterpart, these factors don't have a basic clock
> > > implementation.
> > 
> > I think "multiplier" would be a better name here, considering it is the
> > counterpart of "divider". "factor" implies you can multiply and/or divide
> > the clock rate.
> 
> You're probably right, I didn't though of it that way :)

I also prefer multiplier over factor.

Jim Quinlan submitted a similar patch. See here:

http://www.spinics.net/lists/linux-clk/msg00691.html

I nacked that patch because Stephen and I are trying to figure out how
the basic clock types should work going forward. Code reuse is good, but
they are not very maintainable.

Since there are two potential users of this code, I should reconsider.
Can you two come up with a common implementation that works for both of
you?  Please do not put any CLK_OF_DECLARE stuff in there (there isn't
any now, but I wanted to be clear).

Regards,
Mike

> 
> > Unless of course you plan to add that? :)
> 
> Hmmm, no, not really.
> 
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
