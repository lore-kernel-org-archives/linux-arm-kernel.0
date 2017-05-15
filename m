From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 May 2017 19:07:35 +0200
Subject: [PATCH 2/2 v2] reset: Add a Gemini reset controller
In-Reply-To: <1494593270.2965.5.camel@pengutronix.de>
References: <20170508200740.26194-1-linus.walleij@linaro.org>
 <1494593270.2965.5.camel@pengutronix.de>
Message-ID: <CACRpkdbjFgCJwjZ8j8XfmOEDqQYHZdLNoswgfC83yAoTdyyz_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 2:47 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Mon, 2017-05-08 at 22:07 +0200, Linus Walleij wrote:
>> The Cortina Systems Gemini reset controller is a simple
>> 32bit register with self-deasserting reset lines. It is
>> accessed using regmap over syscon.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v1->v2:
>> - Add an explicit GPL license statement.
>> - Move the reset controller to be identical to the sycon
>>   node, no need to a separate child node for this.
>> - Drop unneeded struct device *dev pointer from state
>>   container.
>> - Print error code on missing regmap.
>> - Use #define from the <dt-bindings/*> to indicate that we
>>   always set the CPU1 reset line to 1 when writing the
>>   resets.
>
> Thank you, looks good to me. I'll include this with the next pull
> request after v4.12-rc1 is released.

I have to repost it because Rob requested that the reset
controller and clock controller be probed directly from the
system controller without any special reset/clock nodes.

I was planning to ask you to ACK it for merge through
ARM SoC instead: as it uses the <dt-bindings/*> things
and that needs to be there to work with the DTS files, we
either need to merge this wholesome through ARM SoC,
or we apply the binding patch into all three trees
(either works with me).

I'll post a v3 so we can discuss.

Yours,
Linus Walleij
