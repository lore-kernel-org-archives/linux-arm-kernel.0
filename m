From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Fri, 24 Aug 2018 01:32:39 +0530
Subject: [PATCH] arm64: dts: Fix various entry-method properties to
 reflect documentation
In-Reply-To: <20180823153110.GA19131@e107155-lin>
References: <113f28acbc55f64762c9f0bcefe076a811f2ed82.1535014078.git.amit.kucheria@linaro.org>
 <20180823153110.GA19131@e107155-lin>
Message-ID: <CAHLCerNoRj6GQRF=NJXwc0U+mJNe=06JGADQr7uT-chD2W-J+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Adding arm-soc folks)

On Thu, Aug 23, 2018 at 9:01 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi Amit,
>
> Thanks for fixing this.
>
> On Thu, Aug 23, 2018 at 02:23:29PM +0530, Amit Kucheria wrote:
>> The idle-states binding documentation[1] mentions that the
>> 'entry-method' property is required on 64-bit platforms and must be
>> set to "psci".
>>
>> commit a13f18f59d26 ("Documentation: arm: Fix typo in the idle-states
>> bindings examples") attempted to fix this earlier but clearly more is
>> needed.
>>
>
> In fact, I assumed I fixed things with commit 978fa436231a ("drivers:
> firmware: psci: unify enable-method binding on ARM {64,32}-bit systems"),
> but I was wrong. I left quite a few instances including juno dtbs.
>
>> Fix the cpu-capacity.txt documentation that uses the incorrect value so
>> we don't get copy-paste errors like these. Clarify the language in
>> idle-states.txt by removing the reference to the psci bindings that
>> might be causing this confusion.
>>
>> Finally, fix devicetrees of various boards to reflect current
>> documentation.
>>
>> [1] Documentation/devicetree/bindings/arm/idle-states.txt (see
>> idle-states node)
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/arm/cpu-capacity.txt | 2 +-
>>  Documentation/devicetree/bindings/arm/idle-states.txt  | 4 ++--
>>  arch/arm64/boot/dts/arm/juno-r1.dts                    | 2 +-
>>  arch/arm64/boot/dts/arm/juno-r2.dts                    | 2 +-
>>  arch/arm64/boot/dts/arm/juno.dts                       | 2 +-
>
> For all the above files,
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks for reviewing, Sudeep.

> How do you plan to merge ? I prefer if you can send it via arm-soc as
> fixes for this cycle with all the necessary acks. Otherwise you may have
> to split this to send via platform maintainers which is bit mundane.

I was hoping to get this merged thru arm-soc tree instead of creating
a patch per platform. But if anybody feels strongly about it, I'm
happy to split them up and feed it through the platform maintainer
trees.

Regards,
Amit
