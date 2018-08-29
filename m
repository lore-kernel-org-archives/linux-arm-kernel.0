From: olof@lixom.net (Olof Johansson)
Date: Wed, 29 Aug 2018 11:54:50 -0700
Subject: [GIT PULL] Amlogic fixes for v4.19-rc
In-Reply-To: <7hk1o9895g.fsf@baylibre.com>
References: <7hk1o9895g.fsf@baylibre.com>
Message-ID: <20180829185450.wmmyoona2hrapnj6@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 08:50:03AM -0700, Kevin Hilman wrote:
> Olof, Arnd,
> 
> A round of DT fixes for Amlogic SoCs for v4.19-rc.
> 
> The are all platform-specific DT, 2 are simple fixes, and the 3
> meson-axg patches are to enable audio devices that were fully enabled by
> reset changes in the late PR recently sent and merged.
> 
> Kevin
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes
> 
> for you to fetch changes up to 1caa378e092f22d02e8a46216cbf1c8e8101163a:
> 
>   ARM: dts: meson8b: fix the clock controller register size (2018-08-29 08:38:21 -0700)
> 
> ----------------------------------------------------------------
> Amlogic DT fixes for v4.19-rc
> - meson8b: fix clock controller register sizes
> - AXG/s400: enable audio devices
> 
> ----------------------------------------------------------------
> Jerome Brunet (3):
>       arm64: dts: meson-axg: add audio fifos
>       arm64: dts: meson-axg: s400: enable audio devices
>       arm64: dts: meson-axg: s400: add sound card

Hmm. So we merged some reset controller changes very late because the audio
drivers had landed and were now going to be useful, but this seems to indicate
that there's more material needed too? Or is it that this enables also for the
64-bit platforms and the 32-bit are already in 4.19?

Those should be 4.20 material by now, since the merge window is behind us.


-Olof
