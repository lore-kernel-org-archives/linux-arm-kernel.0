From: dianders@chromium.org (Doug Anderson)
Date: Mon, 25 Jun 2018 11:50:52 -0700
Subject: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
Message-ID: <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 22, 2018 at 5:46 PM, David Collins <collinsd@codeaurora.org> wrote:
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
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/regulator/Kconfig               |   9 +
>  drivers/regulator/Makefile              |   1 +
>  drivers/regulator/qcom-rpmh-regulator.c | 746 ++++++++++++++++++++++++++++++++
>  3 files changed, 756 insertions(+)

I've been working with David's v7 patch series for a bit of time now
and things have been working well.  v8 looks good.  Feel free to add:

Tested-by: Douglas Anderson <dianders@chromium.org>

...to this patch.  Speaking of which it might be getting very close to
time for this series to land along with David's other series, AKA:

* [1/2] regulator: of: add property for allowed modes specification
  https://patchwork.kernel.org/patch/10395731/

* [2/2] regulator: of: add support for allowed modes configuration
  https://patchwork.kernel.org/patch/10395725/


Specifically I think we are mostly waiting for RPMh to land.  This is
on Andy's plate right now but I think it's happy and just waiting for
the actual push from Andy.


NOTE: I don't know if there anything special we need to do for landing
this and RPMh across two git repositories.  Offline Stephen Boyd
mentioned to me that maybe it was fine to land this in Mark's tree
without the RPMh code since it depends on "QCOM_RPMH", but the "||
COMPILE_TEST" worries me and makes me think auto-builders will start
yelling.  Andy and Mark: what do you think?


If it's helpful to have a link to the latest RPMh, here are patchwork
IDs on linux-arm-msm:

10477501 [v13,01/10] drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs
10477559 [v13,02/10] dt-bindings: introduce RPMH RSC bindings for Qualcomm SoCs
10477545 [v13,03/10] drivers: qcom: rpmh-rsc: log RPMH requests in FTRACE
10477543 [v13,04/10] drivers: qcom: rpmh: add RPMH helper functions
10477537 [v13,05/10] drivers: qcom: rpmh-rsc: write sleep/wake requests to TCS
10477539 [v13,06/10] drivers: qcom: rpmh-rsc: allow invalidation of
sleep/wake TCS
10477533 [v13,07/10] drivers: qcom: rpmh: cache sleep/wake state requests
10477529 [v13,08/10] drivers: qcom: rpmh: allow requests to be sent
asynchronously
10477525 [v13,09/10] drivers: qcom: rpmh: add support for batch RPMH request
10477519 [v13,10/10] drivers: qcom: rpmh-rsc: allow active requests
from wake TCS



-Doug
