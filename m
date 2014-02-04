From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 20:00:18 +0000
Subject: [PATCH] regulator: core: Make regulator object reflect
 configured voltage
In-Reply-To: <CAJAp7Ohn3ch2nK_S8j9ieRBzNeyt6OJmumEhRXXykB9RgMJsQg@mail.gmail.com>
References: <1391493268-3242-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20140204110531.GR22609@sirena.org.uk>
 <CAJAp7OjCnJ=P9Gi20=D9gybREiSaqd1CaQ0K=9fGbCzU1gTFLw@mail.gmail.com>
 <20140204181831.GP22609@sirena.org.uk>
 <CAJAp7Ohn3ch2nK_S8j9ieRBzNeyt6OJmumEhRXXykB9RgMJsQg@mail.gmail.com>
Message-ID: <20140204200018.GZ22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 11:09:03AM -0800, Bjorn Andersson wrote:

> I have a regulator that's being configured from DT as:
> regulator-min-microvolt = <2950000>;
> regulator-max-microvolt = <2950000>;

> In the consumer I do regulator_set_voltage(2.95V).

> As min == max the voltage is applied by the regulator framework on registration
> of the regulator; and the regulator_set_voltage() fails as
> REGULATOR_CHANGE_VOLTAGE is not set for this regulator.

So we should be changing the code to allow a set_voltage() that sets the
voltage to the existing voltage regardless of constraints allowing a
change then - that's what the underlying issue is.  Your change wouldn't
cover the case where the hardware defualt is being used for example.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/0f13e826/attachment-0001.sig>
