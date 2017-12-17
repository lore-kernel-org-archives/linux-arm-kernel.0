From: stefan@agner.ch (Stefan Agner)
Date: Sun, 17 Dec 2017 21:02:56 +0100
Subject: [PATCH 2/9] ARM: dts: imx7-colibri: make sure multiplexed pins
 are not active
In-Reply-To: <CAOMZO5AD6bDEMStEWY8hRG_8gh0RAD_66zboTsKd-cFkPtiLKg@mail.gmail.com>
References: <20171206153005.6144-1-stefan@agner.ch>
 <20171206153005.6144-2-stefan@agner.ch>
 <CAOMZO5AD6bDEMStEWY8hRG_8gh0RAD_66zboTsKd-cFkPtiLKg@mail.gmail.com>
Message-ID: <38b23042a694d56198c398f21c4aa5d1@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-12-16 15:01, Fabio Estevam wrote:
> On Wed, Dec 6, 2017 at 1:29 PM, Stefan Agner <stefan@agner.ch> wrote:
>> The Colibri pins PWM<A> and <D> are multiplexed on the module, make
>> sure the secondary SoC pin is not active.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> I haven't really understood the commit message, but this is probably
> because I don't have access to the schematics.

It means that the modules pins are connected to two SoC pads. It is also
mentioned in the Colibri iMX7 datasheet.

This allows to use the module pin for a different purpose, but we mux it
such that it is usable for the primary purpose (which is PWM).

> 
> Anyway:
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Thanks!

--
Stefan
