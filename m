From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 26 Apr 2013 15:28:10 +0100
Subject: [PATCH 04/32] dmaengine: ste_dma40: Amalgamate DMA source and
 destination channel numbers
In-Reply-To: <CACRpkdbpbQTCxeQ6cCbAkvvQXJMQUhLv8=qcbBgvBVnMDdysOA@mail.gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-5-git-send-email-lee.jones@linaro.org>
 <CACRpkdaauDYTdoBHGG9FO4kKqvCYyCrjY8EGWs5gAQWErGW6_A@mail.gmail.com>
 <20130425090612.GC4623@gmail.com>
 <CACRpkdbV8yEK0470q_-DWv6Q0hAG2wGntXFi5kaLUMgm9b=e-Q@mail.gmail.com>
 <20130425132025.GM4623@gmail.com>
 <CACRpkdbpbQTCxeQ6cCbAkvvQXJMQUhLv8=qcbBgvBVnMDdysOA@mail.gmail.com>
Message-ID: <20130426142810.GD31899@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Apr 2013, Linus Walleij wrote:

> On Thu, Apr 25, 2013 at 3:20 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Thu, 25 Apr 2013, Linus Walleij wrote:
> 
> >> As we may want to support DEV_TO_DEV at some point.
> >>
> >> Then no longer, and that is not related to $SUBJECT.
> >
> > That's not why I'm removing it. The statement can never be true due to
> > the fact that the second evaluation (src_event_group != dst_event_group)
> > can never be true, which is a direct effect of 'THIS_PATCH'.
> 
> OK that is correct, I'm fine with this then ... as part of that other
> patch dealing with unreacable conditions I keep talking about...

Just looking at this now.

Although I agree that the "dst_event_group == STEDMA40_DEV_DST_MEMORY
(-16)" issue can/should be split out prior, I don't think this
"(src_event_group != dst_event_group)" should be, as it is a direct
result of the code that's being changed in this patch here. It makes
no sense to remove it before this patch, as it's still valid and
removing it afterwards violates your break-now, fix-later stipulation.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
