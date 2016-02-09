From: horms@verge.net.au (Simon Horman)
Date: Tue, 9 Feb 2016 19:39:21 +0100
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.6
In-Reply-To: <CAMuHMdVWYVEHTvGYEZkEXpEaMzfZ_NfMAb0o8HtVcJM+GDdfmA@mail.gmail.com>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
 <20160208215130.GJ25468@localhost>
 <CAMuHMdVWYVEHTvGYEZkEXpEaMzfZ_NfMAb0o8HtVcJM+GDdfmA@mail.gmail.com>
Message-ID: <20160209183921.GA1089@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2016 at 08:39:31AM +0100, Geert Uytterhoeven wrote:
> Hi Olof,
> 
> On Mon, Feb 8, 2016 at 10:51 PM, Olof Johansson <olof@lixom.net> wrote:
> > On Thu, Feb 04, 2016 at 03:30:02PM +0100, Simon Horman wrote:
> >> Please consider these Renesas ARM based SoC DT updates for v4.6.
> >>
> >>
> >> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> >>
> >>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.6
> >>
> >> for you to fetch changes up to d7a11140d0a659e5c1f83627792f95b6713030a2:
> >>
> >>   ARM: dts: silk: Enable SCIF_CLK frequency and pins (2016-02-02 14:02:28 +0100)
> >>
> >> ----------------------------------------------------------------
> >> Renesas ARM Based SoC DT Updates for v4.6
> >>
> >> * Use SCIF and USBHS fallback compatibility strings
> >> * Add Baud Rate Generator (BRG) support for (H)SCIF
> >> * Enable SCIF_CLK frequency and pins
> >> * Use GIC_* defines
> >> * Migrate to generic l2c OF initialization on r8a7740
> >> * Enable audio on r8a7793/gose
> >> * Enable HDMI vidio out on r8a7793
> >> * Enable i2c on r8a7793/gose
> >> * Enable QSPI on alt
> >> * Enable GPIO keys and leds on gise
> >> * Enable audio on porter
> >> * Enable DU on porter
> >>
> >> ----------------------------------------------------------------
> >> Geert Uytterhoeven (22):
> >>       ARM: shmobile: r8a7740: Migrate to generic l2c OF initialization
> >>       ARM: shmobile: r8a7740: Remove mapping of L2 cache controller registers
> >
> > Hmm. Those aren't DT changes. There's also nothing for r8a7740 to convert
> > L2 init to DT earlier in this branch, which makes this look like it's just
> > a generic cleanup that should go in independently in your cleanup branch.
> >
> > Or am I missing some dependency that isn't obvious? If I'm not, then please
> > respin this branch and move those to the place they belong (cleanup).
> 
> The dependency is commit 374e70075e58acfe ("ARM: shmobile: r8a7740 dtsi: Add
> L2 cache-controller node"), which has already entered mainline in v4.5-rc1.
> 
> So I agree with your comments.

Sorry for the mix-up.
I'll see about respinning this.
