From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 2 Sep 2014 10:13:01 -0300
Subject: ARM: mx28: cpufreq-cpu0 support?
In-Reply-To: <54055116.4030608@lategoodbye.de>
References: <53F9B4BF.2050802@lategoodbye.de> <20140825080123.GA12289@dragon>
 <53FB1041.5010208@lategoodbye.de>
 <CAOMZO5CG7mw5W4D3fRPE3TGxQ6-3pTtDJrsNnieN8XKE9dGofQ@mail.gmail.com>
 <CAOMZO5CnuWJ9EaLUW8DYFU1Dzeh=92tux0zoUBKoW-L=VWZhhg@mail.gmail.com>
 <540412A9.4090806@lategoodbye.de>
 <CAOMZO5A7-66LJtv4O2TghN3gVzme4N6JFMYd8TV7zXhUhsXedQ@mail.gmail.com>
 <54055116.4030608@lategoodbye.de>
Message-ID: <CAOMZO5A3n6HV_A+U5pjzbHQMhcpmq7gw0e0aT87GGTyTZKeZ9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 2, 2014 at 2:09 AM, Stefan Wahren <info@lategoodbye.de> wrote:

> thanks again. Now i unterstand much more, but otherwise the portation won't
> be straight forward. The old source in drivers/regulator/mxs-regulator.c
> needs a low level part located in arch/arm/plat-mx28/power.c . As far as i
> know, the low level part needs to move into the devicetree binding and into
> the mxs-regulator.c . Am i right?

Yes, I think you are right.

> Yesterday i had looked into the mx28 reference manual and into the low level
> part of the mxs regulator. The reference manual defines four voltage
> regulators: vddd, vdda, vddio and vddmem plus a overall current regulator.
> But the low level part make use of vddd, vdda, vddio, vddio_bo and the
> overall current.
>
> Do i need the brown out regulator (vddio_bo) and the vddmem?

As far as I understand vddmem is not used on mx28evk. From the mx28
reference manual;

"11.12.8 VDDMEM Supply Targets Control Register
(HW_POWER_VDDMEMCTRL)
This register controls the voltage target for a memory supply
generated from VDDA. This
supply is intended for use with external memories such as LV-DDR that
have unique voltage
requirements not compatible with VDDIO, VDDA , or VDDD."
