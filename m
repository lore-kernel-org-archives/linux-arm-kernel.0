From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 24 Feb 2014 14:23:50 -0300
Subject: [PATCH v3 0/2] regulator: core: Fix ops->enable/disable usage
In-Reply-To: <20140223051209.GK25940@sirena.org.uk>
References: <1392914164-28596-1-git-send-email-mpa@pengutronix.de>
 <20140223051209.GK25940@sirena.org.uk>
Message-ID: <CAOMZO5BPvCcx_f09Khuw8MVxrR18fnv9e1xeuJ0c_8G22AR53g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 23, 2014 at 2:12 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Feb 20, 2014 at 05:36:02PM +0100, Markus Pargmann wrote:
>> Hi,
>>
>> These two patches replace all ops->enable/disable by
>> _regulator_do_disable/enable function calls. These wrappers also handle gpio
>> regulators.
>
> Applied both, thanks.

With these two patches applied I get the following error on
mx6qsabresd running today's linux-next:

vdd1p1: failed to enable
anatop_regulator regulator-1p1.2: failed to register vdd1p1
anatop_regulator: probe of regulator-1p1.2 failed with error -22
vdd3p0: failed to enable
anatop_regulator regulator-3p0.3: failed to register vdd3p0
anatop_regulator: probe of regulator-3p0.3 failed with error -22
vdd2p5: failed to enable
anatop_regulator regulator-2p5.4: failed to register vdd2p5
anatop_regulator: probe of regulator-2p5.4 failed with error -22
vddarm: 725 <--> 1450 mV at 1100 mV
vddpu: 725 <--> 1450 mV at 1100 mV
vddsoc: 725 <--> 1450 mV at 1175 mV
....

pfuze100-regulator 1-0008: Full layer: 1, Metal layer: 0
pfuze100-regulator 1-0008: FAB: 0, FIN: 0
SW1AB: failed to enable
pfuze100-regulator 1-0008: register regulatorSW1AB failed
pfuze100-regulator: probe of 1-0008 failed with error -22


Reverting these two patches the regulators probe successfully.

Any ideas?

Regards,

Fabio Estevam
