From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 29 Mar 2012 14:33:33 -0700
Subject: [PATCH] serial: PL011: move interrupt clearing
In-Reply-To: <CACxGe6u+KeYzWwiJ7MK7pWG444Y99CQ1LLCZP4m3R=zdYFR_pg@mail.gmail.com>
References: <1332357318-8017-1-git-send-email-linus.walleij@linaro.org>
 <CACxGe6u+KeYzWwiJ7MK7pWG444Y99CQ1LLCZP4m3R=zdYFR_pg@mail.gmail.com>
Message-ID: <20120329213333.GA15231@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 02:49:37PM -0600, Grant Likely wrote:
> On Wed, Mar 21, 2012 at 1:15 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > Commit 360f748b204275229f8398cb2f9f53955db1503b
> > "serial: PL011: clear pending interrupts"
> > attempts to clear interrupts by writing to a
> > yet-unassigned memory address. This fixes the issue.
> >
> > The breaking patch is marked for stable so should be
> > carried along with the other patch.
> >
> > Cc: Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: stable <stable@vger.kernel.org>
> > Reported-by: Viresh Kumar <viresh.kumar@st.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Ugh; the original patch is obviously broken.  How did it get applied
> without testing?
> 
> Greg, can you get this out to Linus ASAP please?  I have one comment
> below, but I don't think it should block merging this patch.
> 
> Tested-by: Grant Likely <grant.likely@secretlab.ca>

Thanks, I'll get it to him after 3.4-rc1 is out, in a few days, along
with other tty fixes being queued up.

greg k-h
