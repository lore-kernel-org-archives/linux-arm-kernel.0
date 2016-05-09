From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 9 May 2016 07:19:46 +0200
Subject: [GIT PULL] clk: tegra: Changes for v4.7-rc1
In-Reply-To: <20160503000248.GB3492@codeaurora.org>
References: <1461945596-24090-1-git-send-email-thierry.reding@gmail.com>
 <20160503000248.GB3492@codeaurora.org>
Message-ID: <20160509051946.GA18753@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2016 at 05:02:48PM -0700, Stephen Boyd wrote:
> On 04/29, Thierry Reding wrote:
> > Hi Michael, Stephen,
> > 
> > The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> > 
> >   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.7-clk
> > 
> > for you to fetch changes up to 2690e912644e610854c4c3b23d0a0daec9d030ca:
> > 
> >   clk: tegra: dfll: Reformat CVB frequency table (2016-04-28 12:41:54 +0200)
> > 
> > Note that the first patch is this pull request is a dependency for a
> > larger series that will have to go in through the ARM-SoC tree in order
> > to properly handle the dependencies.
> > 
> 
> Thanks. Pulled.
> 
> Are there any thoughts on making that hw control stuff more
> generic? Perhaps using something like power domains to do that
> instead of having drivers cross-call to the clk driver with
> custom tegra APIs?

I'm not aware of any API that would fit in this case. Power domains
would be misleading because power management isn't involved. One other
alternative that I had thought about is to make it a "virtual" reset,
but that is equally misleading because nothing is really being reset
here.

Yet another option might be to make it a "virtual" clock, though it'd
have to be somewhat hacky because we need two steps (one to enable HW
control and another to start the HW sequencer). That could be
implemented using ->prepare() and ->enable(), respectively, but it's
really not a clock either.

I welcome any ideas on how to turn this into something generic, though.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160509/a91385f5/attachment.sig>
