From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 15:04:57 +0200
Subject: [PATCH] ARM: tegra: Fix typoed ams,ext-control properties
In-Reply-To: <1404931997-7118-1-git-send-email-ttynkkynen@nvidia.com>
References: <1404931997-7118-1-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <20140711130456.GB10827@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 09:53:17PM +0300, Tuomas Tynkkynen wrote:
> The property for enabling external rail control on the AS3722 is
> ams,ext-control, not ams,external-control. Since the external rail
> control property was previously being ignored, LP1 suspend on these
> boards wasn't actually turning the CPU rail off at all.
> 
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> ---
> So here's a dilemma, either change the existing DTs, change the
> binding + driver, or make the driver recognize both properties.
> I chose the first one since the old behaviour was broken in the
> first place and the old DTs stay as buggy as they were before.
> 
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts | 6 +++---
>  arch/arm/boot/dts/tegra124-venice2.dts    | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

Applied to the for-3.17/dt branch. Thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/82f5c73b/attachment.sig>
