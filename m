From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 12 Nov 2014 13:20:20 +0100
Subject: [PATCH] ARM: dts: tegra: move serial aliases to per-board
In-Reply-To: <1415738970-7963-1-git-send-email-olof@lixom.net>
References: <1415738970-7963-1-git-send-email-olof@lixom.net>
Message-ID: <20141112122017.GC30821@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 12:49:30PM -0800, Olof Johansson wrote:
> There are general changes pending to make the /aliases/serial* entries
> number the serial ports on the system. On tegra, so far the ports have been
> just numbered dynamically as they are configured so that makes them change.
> 
> To avoid this, add specific aliases per board to keep the old numbers. This
> allows us to change the numbering by default on future SoCs while keeping the
> numbering on existing boards.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> Stephen/Thierry/Alex, as noticed this week we really should try to get
> this in before the 3.19 merge window so that the global aliases change
> can happen there without regression.
> 
> If you have more fixes queued up, feel free to add this to the next pull
> request. If not, a review and ack would be appreciated.
> 
>  arch/arm/boot/dts/tegra114-dalmore.dts        |    1 +
>  arch/arm/boot/dts/tegra114-roth.dts           |    4 ++++
>  arch/arm/boot/dts/tegra114-tn7.dts            |    4 ++++
>  arch/arm/boot/dts/tegra114.dtsi               |    7 -------
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts     |    1 +
>  arch/arm/boot/dts/tegra124-nyan-big.dts       |    1 +
>  arch/arm/boot/dts/tegra124-venice2.dts        |    1 +
>  arch/arm/boot/dts/tegra124.dtsi               |    7 -------
>  arch/arm/boot/dts/tegra20-harmony.dts         |    1 +
>  arch/arm/boot/dts/tegra20-iris-512.dts        |    5 +++++
>  arch/arm/boot/dts/tegra20-medcom-wide.dts     |    4 ++++
>  arch/arm/boot/dts/tegra20-paz00.dts           |    2 ++
>  arch/arm/boot/dts/tegra20-seaboard.dts        |    1 +
>  arch/arm/boot/dts/tegra20-tamonten.dtsi       |    1 +
>  arch/arm/boot/dts/tegra20-trimslice.dts       |    1 +
>  arch/arm/boot/dts/tegra20-ventana.dts         |    1 +
>  arch/arm/boot/dts/tegra20-whistler.dts        |    1 +
>  arch/arm/boot/dts/tegra20.dtsi                |    8 --------
>  arch/arm/boot/dts/tegra30-apalis-eval.dts     |    4 ++++
>  arch/arm/boot/dts/tegra30-beaver.dts          |    1 +
>  arch/arm/boot/dts/tegra30-cardhu.dtsi         |    2 ++
>  arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |    3 +++
>  arch/arm/boot/dts/tegra30.dtsi                |    8 --------
>  23 files changed, 39 insertions(+), 30 deletions(-)

I have applied this to the for-3.19/dt branch. So for anything that is
post Tegra124 the new rule shall be to add aliases to the SoC .dtsi and
then use consistent numbering of UART ports across boards?

The alternative is to remain consistent with what this patch does, which
would be to make the serial port numbering a property of the board. That
doesn't sound too bad to me either since it'll hide all the unused ports
on a given board.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141112/7e79586f/attachment-0001.sig>
