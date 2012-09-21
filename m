From: linux@prisktech.co.nz (Tony Prisk)
Date: Fri, 21 Sep 2012 06:42:44 +0000
Subject: [GIT PULL RESEND] arm-soc: vt8500: Convert mach-vt8500 to
 devicetree
In-Reply-To: <1348207824.907.5.camel@gitbox>
References: <1348119906.8199.3.camel@gitbox>
 <20120920232807.GA13788@quad.lixom.net> <1348207824.907.5.camel@gitbox>
Message-ID: <1348209938.1669.4.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-21 at 18:07 +0000, Tony Prisk wrote:
> On Thu, 2012-09-20 at 16:28 -0700, Olof Johansson wrote:
> > Hi,
> > 
> > On Thu, Sep 20, 2012 at 05:45:06PM +1200, Tony Prisk wrote:
> > > Please disregard the last pull request - commit id's were invalid.
> > > This one is now correct.
> > > 
> > > The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:
> > > 
> > >   Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.code.sf.net/p/linuxwmt/code tags/vt8500-for-next
> > > 
> > > for you to fetch changes up to 0cd5434aae73698aa4a48542bd8d1428d44820cb:
> > > 
> > >   arm: vt8500: Update arch-vt8500 to devicetree support. (2012-09-20 07:23:26 +1200)
> > > 
> > > ----------------------------------------------------------------
> > > Update mach-vt8500 to devicetree and remove non-dt code.
> > > 
> > > ----------------------------------------------------------------
> > > Tony Prisk (8):
> > >       arm: vt8500: Add device tree files for VIA/Wondermedia SoC's
> > >       rtc: vt8500: Add devicetree support for vt8500-rtc
> > >       serial: vt8500: Add devicetree support for vt8500-serial
> > >       video: vt8500: Add devicetree support for vt8500-fb and wm8505-fb
> > >       arm: vt8500: clk: Add Common Clock Framework support
> > >       arm: vt8500: doc: Add device tree bindings for arch-vt8500 devices
> > >       arm: vt8500: gpio: Devicetree support for arch-vt8500
> > >       arm: vt8500: Update arch-vt8500 to devicetree support.
> > 
> > Overall this series looks great, however I pinged Rob Herring about it
> > since I didn't see his Acked-by on the bindings patch. It sounds like he
> > has some comments on the display pieces, so unless you can break those
> > out and do everything else for 3.7, we might need to hold off until that
> > has been settled.
> > 
> > 
> > -Olof
> 
> This was discussed when the series was originally posted. The display
> mode binding was still floating around with V1 suggestions so I had to
> make a best-guess as to how it would end up.
> 
> Without it, the patch will break support for 95% of users as framebuffer
> is the only output device. 
> 
> Given that I can't fix it as the videomode helper patch is still getting
> revisions (Last I saw v4 had outstanding queries against it) I guess it
> will have to wait until next time around.
> 
> Regards
> 
> Tony P

I think I was a bit hasty in my reply.

Having looked at v4 of the videomode helper patch, there is only naming
differences between my display node and the v4 binding. These could be
fixed in a few minutes.

Given the late stage, how likely is it that the videomode helper is
going to make it in to 3.7?

If not, couldn't this patchset go through with the board file changes to
the display node to bring it inline with the expected binding? 

I plan to submit a new framebuffer driver for 3.8 which could be
modified to use the helper when its in 3.8 (assuming it doesn't make
3.7) - or the existing framebuffer driver could be patched to use the
of_helper. I realise this creates a bit of churn on the framebuffer
code, but more than likely its going to occur anyway if the new driver
is accepted.

Regards

Tony P
