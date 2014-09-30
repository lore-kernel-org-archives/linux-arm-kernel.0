From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 30 Sep 2014 12:56:53 -0700
Subject: [PATCH 1/4] ARM: DT: apq8064: add rpm support
In-Reply-To: <542B00C1.3010702@codeaurora.org>
References: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1411982092-7922-1-git-send-email-srinivas.kandagatla@linaro.org>
 <5429DA95.80505@codeaurora.org>
 <20140930050203.GG28481@sonymobile.com>
 <542AF5FE.1000006@codeaurora.org>
 <20140930190023.GS28481@sonymobile.com>
 <542B00C1.3010702@codeaurora.org>
Message-ID: <20140930195652.GT28481@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 30 Sep 12:13 PDT 2014, Stephen Boyd wrote:

> On 09/30/14 12:00, Bjorn Andersson wrote:
> >
> > Hmm, seems I got that wrong, sorry about that.
> >
> > But do you mean "all wrong" as in that I use the wrong bit or to some greater
> > extent? Currently all following requests should timeout, but maybe we should
> > have a faster fail-path when we've hit this point?
> 
> Yes. We just ack the interrupt and go on happy to keep allowing clients
> to request things. I'd rather see us blow up or start failing requests,
> or maybe both.
> 

Okay, I naively figured that the RPM would be dead after this happened and from
this point we would start getting timeouts. Let's ack the right bit and fail
early after the RPM have rejected things.

> >
> > From a practical pov I guess that once the rpm starts returning errors on
> > updates to regulators, root clocks and bus scaling then most of the system is
> > becoming useless.
> 
> Right. Rebooting will be required fairly soon.
> 

Yes, but we want something else to trigger that right?

Regards,
Bjorn
