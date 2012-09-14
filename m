From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Sep 2012 10:41:45 -0600
Subject: [PATCH v4 00/10] pinctrl: mvebu: pinctrl driver
In-Reply-To: <1347550912-18021-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <50535E49.5060903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2012 09:41 AM, Sebastian Hesselbarth wrote:
> This patch set adds a core pinctrl driver for Marvell MVEBU SoCs and
> SoC specific stubs for Armada 370, Armada XP, Dove, and Kirkwood.
> The SoC specific stubs use the pinctrl-mvebu core driver that handles
> pinctrl API and register accesses for common pinctrl registers.
> 
> As especially Dove has some pinctrl registers that do not match the
> common pinctrl register layout the core driver has been extended by
> some callbacks to allow uncommon Dove pinctrl registers.
> 
> DT binding documentation is added for all supported SoCs but as
> Dove and Kirkwood are not yet ready for full DT support, the pinctrl
> driver is only activated for Armada 370 and XP.
> 
> The driver of latest patch v4 has been tested on Dove, Armada 370, 
> Armada XP, and 88f6281 variant of Kirkwood.

The series,
Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>

(Mainly the DT bindings and .dts file edits)

In past versions of this series, we were had discussions about the best
way to represent the data tables in the SoC-specific pinctrl drivers. I
haven't actually looked at the current state in this patchset, but since
this is an internal implementation detail and doesn't affect the DT
bindings at all, I figure it's not a big deal right now; if it is ever a
problem, it can be fixed without affecting anything outside the driver,
so I won't worry about it:-)
