From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 12 Dec 2013 19:58:46 -0800
Subject: [PATCH 1/2] gpio: msm: Fix irq mask/unmask by writing bits
 instead of numbers
In-Reply-To: <CACRpkdY8W8tGVH-Os5neeFfHWjojdB5fBbjgWcsWkiMyJj=YAA@mail.gmail.com>
References: <1386717544-478-1-git-send-email-sboyd@codeaurora.org>
 <CACRpkdY8W8tGVH-Os5neeFfHWjojdB5fBbjgWcsWkiMyJj=YAA@mail.gmail.com>
Message-ID: <20131213035845.GK11990@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 12 Dec 11:02 PST 2013, Linus Walleij wrote:

> On Wed, Dec 11, 2013 at 12:19 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > We should be writing bits here but instead we're writing the
> > numbers that correspond to the bits we want to write. Fix it by
> > wrapping the numbers in the BIT() macro. This fixes gpios acting
> > as interrupts.
> >
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> I've applied this for fixes and tagged for stable.
> Bj?rn, Rohit: OK?

This looks good.

JFYI; the pinctrl-msm is written with gpio-msm-v2 in mind as well, so replacing
it with pinctrl is on my todo list...

Regards,
Bjorn
