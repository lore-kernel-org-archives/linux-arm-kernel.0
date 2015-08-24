From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Aug 2015 20:14:28 +0100
Subject: Prevent list poison values from being mapped by userspace
 processes
In-Reply-To: <CAGXu5jJFf+9OgnGt_Cx5Q-Pht7LAT7M-sSXftTDORybrr+SECg@mail.gmail.com>
References: <CABXk95C=CpeL4mNmS6-jJ-0bMJf6fawwfs6DM1-p8FctTEFbpw@mail.gmail.com>
 <20150821133043.GV7557@n2100.arm.linux.org.uk>
 <CAGXu5jJ8KOoVkx99rrajEEx77Z6zO4TzCXaXkB74zv9QQFuJFw@mail.gmail.com>
 <20150824184709.GE7557@n2100.arm.linux.org.uk>
 <CAGXu5jJFf+9OgnGt_Cx5Q-Pht7LAT7M-sSXftTDORybrr+SECg@mail.gmail.com>
Message-ID: <20150824191427.GF7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 11:51:04AM -0700, Kees Cook wrote:
> On Mon, Aug 24, 2015 at 11:47 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > That's something which Catalin indicated that he'll work on.  However,
> > he said in a public email last week that he won't be around for a while.
> >
> > So, I have no immediate solution for LPAE - it looks like LPAE will
> > require switching the page tables on kernel entry or exit, and again
> > each and every time we want to perform a userspace access.  How this
> > is done is not something that has been discussed, and neither do we
> > yet know how expensive this will be.  There are a number of places in
> > the kernel where a large number of get_user()s or put_user()s follow
> > one after each other, which necessitates switching back and forth
> > multiple times.  We may need to address some of those areas by
> > converting them to copy_(to|from)_user().
> 
> By the way, have you looked at grsecurity's implementation of these
> protections? They've been using domains for a while now, and I think
> have an LPAE solution as well.

*Sigh*.

No, and I really don't care - if people want to do development work out
of the mainline kernel and not bother to talk about getting it upstream,
it's their loss.  As far as I'm concerned, such external work doesn't
exist.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
