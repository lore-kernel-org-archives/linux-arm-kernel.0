From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 15 Jun 2013 18:59:39 -0700
Subject: [RESEND,PATCHv6 1/1] Add support for GMT G762/G763 PWM fan
 controllers
In-Reply-To: <87sj0jhuhn.fsf@natisbad.org>
References: <87sj0jhuhn.fsf@natisbad.org>
Message-ID: <20130616015939.GA5535@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 12:36:20AM +0200, Arnaud Ebalard wrote:
> 
> GMT G762/763 fan speed PWM controller is connected directly to a fan
> and performs closed-loop or open-loop control of the fan speed. Two
> modes - PWM or DC - are supported by the chip. Introduced driver
> provides various knobs to control the operations of the chip (via
> sysfs interface). Specific characteristics of the system can be passed
> either using board init code or via DT. Documentation for both the
> driver and DT bindings are also provided.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
> Hi Guenter,
> 
> In the end, I think handling the clock properly for DT path
> (clk_prepare_enable() and associated clk_disable_unprepare()
> for both error and module unloading) adds some code but I
> do not see how to spare this. Comments welcome.
> 
> If you have additional comments and a new version is required,
> I'll handle those with Simon's tests on its platform.
> 
We might need to be more careful with the clocks. Several drivers
save the value retrieved with of_clk_get() and call clk_put()
afterwards. But some drivers don't do that, so I don't really
know the implications.

I'll look into it some more to make sure everything is correct.

Guenter
