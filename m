From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Jun 2015 09:11:42 +0800
Subject: [PATCH v2 05/12] ARM: imx: setup tctl register in device
 specific function
In-Reply-To: <CAMAWPa-1MPgzT1GJQx4SjmfQpj9zdwsAw-qvLWZjVhoM66nHsQ@mail.gmail.com>
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
 <1432308599-28643-6-git-send-email-shawn.guo@linaro.org>
 <CAMAWPa-1MPgzT1GJQx4SjmfQpj9zdwsAw-qvLWZjVhoM66nHsQ@mail.gmail.com>
Message-ID: <20150602011139.GP16165@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Mon, Jun 01, 2015 at 04:53:28PM -0700, Kevin Hilman wrote:
> Hi Shawn,
> 
> On Fri, May 22, 2015 at 8:29 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > It creates a gpt device speicific data structure and adds function hook
> > gpt_setup_tctl in there to set up gpt TCTL register.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Starting with next-20150529, imx6dl-wandboard (both dual and solo)
> started having boot failures[1].  Today I bisected it down to this
> commit.  It didn't revert cleanly, so I didn't verify that this patch
> alone is the root cause, but reproducing the boot failure should be
> pretty easy on wandboard with recent linux-next.

The imx clocksource driver was marked as BROKEN on linux-next, because
it causes a build error on powerpc allyesconfig build [1].  I'm working
on a fix for it.

Can you please try to remove the BROKEN mark in your test to see if it
fixes your problem?

Sorry for the breakage.

Shawn

[1] http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg901156.html
