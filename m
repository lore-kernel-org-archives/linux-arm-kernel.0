From: joe@perches.com (Joe Perches)
Date: Tue, 16 Aug 2016 11:01:36 -0700
Subject: [PATCH v2] ARM: Add missing newline terminators to kernel messages
In-Reply-To: <CAMuHMdWQae93bbrvxGBpwsw5JGCF85+KF4xZDyi=QTJaT9pWbw@mail.gmail.com>
References: <1471354832-18456-1-git-send-email-geert+renesas@glider.be>
 <1471367313.4075.167.camel@perches.com>
 <CAMuHMdWQae93bbrvxGBpwsw5JGCF85+KF4xZDyi=QTJaT9pWbw@mail.gmail.com>
Message-ID: <1471370496.4075.170.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-08-16 at 19:50 +0200, Geert Uytterhoeven wrote:
> Hi Joe,
> 
> On Tue, Aug 16, 2016 at 7:08 PM, Joe Perches <joe@perches.com> wrote:
> > 
> > On Tue, 2016-08-16 at 15:40 +0200, Geert Uytterhoeven wrote:
> > > 
> > > Before commit 874f9c7da9a4acbc ("printk: create pr_<level>
> > > functions"),
> > > pr_*() calls without a trailing newline characters would be
> > > printed with
> > > a newline character appended, both on the console and in the
> > > output of
> > > the dmesg command.
> > Hey Geert.
> > 
> > This doesn't apply to -next as the pr_notice/pr_cont below is
> > properly changed to a single pr_notice.
> In which -next?
> 
> Not in next-20160816, where the patch applies cleanly.
> Also not in arm/for-next.

My mistake, I was in the wrong directory.
It doesn't apply to Linus' tree.

Still, it'd be slightly nicer to use a single
pr_notice than the pr_notice/pr_cont.

cheers, Joe
