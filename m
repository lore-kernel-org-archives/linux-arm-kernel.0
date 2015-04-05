From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 5 Apr 2015 15:13:39 +0100
Subject: [PATCH 00/14] Fix fallout from per-user struct clk patches
In-Reply-To: <CAMuHMdWue2Pw15j_2ikhSQWxOMGLLO4ojmmyxSvZ=9YwD_+14w@mail.gmail.com>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
 <CAMuHMdWue2Pw15j_2ikhSQWxOMGLLO4ojmmyxSvZ=9YwD_+14w@mail.gmail.com>
Message-ID: <20150405141339.GF4027@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 05, 2015 at 11:04:56AM +0200, Geert Uytterhoeven wrote:
> Hi Russell,
> 
> On Fri, Apr 3, 2015 at 7:11 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Sorry for posting this soo close to the 4.1 merge window, I had
> > completely forgotten about this chunk of work I did earlier this
> > month.
> >
> > The per-user struct clk patches rather badly broke clkdev and
> > various other places.  This was reported, but was forgotten about.
> > Really, the per-user clk stuff should've been reverted, but we've
> > lived with it far too long for that.
> >
> > So, our only other option is to now rush these patches into 4.1
> > and hope for the best.
> >
> > The series cleans up quite a number of places too...
> 
> Thanks for your patches!
> 
> Can you please tell which are critical fixes for regressions, and which are
> cleanups? It's not so obvious to me from the patch descriptions.

The 5th one is the most important as far as fixing the regression caused
by the per-user clk patches.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
