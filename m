From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 10 Apr 2018 15:40:52 +0200
Subject: [PATCH V7 00/13] drivers: Boot Constraint core
In-Reply-To: <cbcfeb15-d940-f066-739d-25adfe09f019@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
 <20180322012606.vuaemu3pvpeojtwr@vireshk-mac-ubuntu>
 <20180323150420.GA21152@kroah.com>
 <cbcfeb15-d940-f066-739d-25adfe09f019@linaro.org>
Message-ID: <1523367652.4981.9.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Georgi,

Am Freitag, den 30.03.2018, 18:24 +0300 schrieb Georgi Djakov:
[...]
> The interconnect core takes requests from consumer drivers for their
> bandwidth needs and configures the hardware to keep the lowest possible
> power profile. I think that the boot constraint patches would be useful
> to make a board run at maximum performance during boot, until all
> consumer drivers are probed and all bandwidth requests are taken into
> account.

Can you please describe how this bootconstraints core integration is
simpler than a "run things at max performance until late kernel init",
which could be triggered by a simple initcall similar to what is done
for clocks and regulators?

To me the bootcontraints stuff looks like a fairly complex solution and
your use-case doesn't even sound like you strictly want to keep a
bootloader configuration, but rather run things at max performance
until you are reasonably sure that you got all the necessary bandwidth
requests.

Regards,
Lucas
