From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 17 Jun 2014 10:07:57 -0700
Subject: [PATCH v3 0/3] Qualcomm Resource Power Manager driver
In-Reply-To: <1402944372-31901-1-git-send-email-bjorn.andersson@sonymobile.com>
 (Bjorn Andersson's message of "Mon, 16 Jun 2014 11:46:09 -0700")
References: <1402944372-31901-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <7hvbrzbh1u.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Paul Walmsley

Bjorn Andersson <bjorn.andersson@sonymobile.com> writes:

> This series adds a regulator driver for the Resource Power Manager found in
> Qualcomm 8660, 8960 and 8064 based devices.
>
> The RPM driver exposes resources to its child devices, that can be accessed to
> implement drivers for the regulators, clocks and bus frequency control that's
> owned by the RPM in these devices.
>
> Changes since v2:
>   - Fix copy-paste error in dt binding
>   - Correct incomplete move from mfd to soc
>   - Correct const mistake in regulator driver
>
> Changes since v1:
>   - Moved rpm driver to drivers/soc

I'm not sure I follow the motivation for having this under drivers/soc?

In fact, my (possibly incorrect) understanding of this Resource Power
Manager is that it's actually to manage communication/control of
resources that are actually handled off the SoC by a microcontroller.

I added Paul W. to Cc so he can correct me, but I think this is a ways
off from the goal of what drivers/soc was for.

Kevin
