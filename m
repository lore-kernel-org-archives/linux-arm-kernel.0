From: dianders@chromium.org (Doug Anderson)
Date: Wed, 6 Jun 2018 15:58:27 -0700
Subject: [PATCH v6 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <6d7abf248493cf81d62eb17ecb5030783aa85f72.1528138319.git.collinsd@codeaurora.org>
References: <cover.1528138319.git.collinsd@codeaurora.org>
 <6d7abf248493cf81d62eb17ecb5030783aa85f72.1528138319.git.collinsd@codeaurora.org>
Message-ID: <CAD=FV=V7ZywhYeVw91QaPuvDTWDW=Fp7nVxOCiKUdev=uwL+fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 4, 2018 at 12:15 PM, David Collins <collinsd@codeaurora.org> wrote:
> Add the QCOM RPMh regulator driver to manage PMIC regulators
> which are controlled via RPMh on some Qualcomm Technologies, Inc.
> SoCs.  RPMh is a hardware block which contains several
> accelerators which are used to manage various hardware resources
> that are shared between the processors of the SoC.  The final
> hardware state of a regulator is determined within RPMh by
> performing max aggregation of the requests made by all of the
> processors.
>
> Add support for PMIC regulator control via the voltage regulator
> manager (VRM) and oscillator buffer (XOB) RPMh accelerators.
> VRM supports manipulation of enable state, voltage, and mode.
> XOB supports manipulation of enable state.
>
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> ---
>  drivers/regulator/Kconfig               |   9 +
>  drivers/regulator/Makefile              |   1 +
>  drivers/regulator/qcom-rpmh-regulator.c | 767 ++++++++++++++++++++++++++++++++
>  3 files changed, 777 insertions(+)

Assuming Mark is OK with this, it looks good to me now.  My previous
feedback is resolved and I'm OK with the hardcoded current loads in
the driver for now until we come up with something better.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

NOTE: Presumably this can't actually land anywhere :( until the RPMh
patchset lands somewhere and that's still sitting in limbo waiting for
Qualcomm to spin the patches.  Presumably once RPMh lands someone will
need to put it somewhere that can be pulled into the relevant trees so
we don't need to wait for a whole merge window...


-Doug
