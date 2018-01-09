From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 9 Jan 2018 07:26:43 -0200
Subject: [PATCH V2 2/2] ARM: dts: imx7s: add snvs rtc clock
In-Reply-To: <1515466276-5541-2-git-send-email-Anson.Huang@nxp.com>
References: <1515466276-5541-1-git-send-email-Anson.Huang@nxp.com>
 <1515466276-5541-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5DKsgydHaoKrrRngMck_9aQqFja9SParvDiD6V79ryuHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Tue, Jan 9, 2018 at 12:51 AM, Anson Huang <Anson.Huang@nxp.com> wrote:

> +   - clocks
> +      Usage: required if SNVS LP RTC requires explicit enablement of clocks
> +      Value type: <prop_encoded-array>
> +      Definition:  A list of phandle and clock specifier pairs describing
> +          the clocks required for enabling and disabling SNVS LP RTC.


It is a single clock that is used here, so it would be better to
describe the text as:

      Definition:  A clock specifier describing the clock required for
enabling and disabling SNVS LP RTC

> +   - clock-names
> +      Usage: required if SNVS LP RTC requires explicit enablement of clocks
> +      Value type: <string>
> +      Definition: A list of clock name strings in the same order as the
> +          clocks property.

and here you must describe that the name should be "snvs-rtc":

      Definition: Clock name string should be "snvs-rtc".
