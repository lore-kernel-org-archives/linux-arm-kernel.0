From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 24 Aug 2011 00:45:13 +0530
Subject: [RFC/PATCH v2 10/13] dt: omap4: panda board: set clock freq for
	i2c devices
In-Reply-To: <4E53F99B.3060308@ti.com>
References: <1314074021-25186-11-git-send-email-manjugk@ti.com>
	<4E537F6B.4060608@ti.com> <4E53F99B.3060308@ti.com>
Message-ID: <CAC63_iTiXQUFYwyRshE7gx-MLbV4pHdbwDJCs0nSsL1H5oRwBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Wed, Aug 24, 2011 at 12:33 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
>> From: G, Manjunath Kondaiah<manjugk@ti.com>
>> To: devicetree-discuss at lists.ozlabs.org
>> CC: linux-omap at vger.kernel.org, linux-arm-kernel at lists.infradead.org
>>
>>
>> Update omap4 panda dts file with required clock frequencies
>> for the i2c client devices existing on panda board.
>>
>> Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
>> ---
>> ? arch/arm/boot/dts/omap4-panda.dts | ? 16 ++++++++++++++++
>> ? 1 files changed, 16 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4-panda.dts
>> b/arch/arm/boot/dts/omap4-panda.dts
>> index c28aa95..6b831ca 100644
>> --- a/arch/arm/boot/dts/omap4-panda.dts
>> +++ b/arch/arm/boot/dts/omap4-panda.dts
>> @@ -3,4 +3,20 @@
>> ? / {
>> ? ? ? ?model = "TI OMAP4 PandaBoard";
>> ? ? ? ?compatible = "ti,omap4-panda", "ti,omap4430";
>> +
>> + ? ? ? i2c1 {
>> + ? ? ? ? ? ? ? clock-frequency =<400000>;
>> + ? ? ? };
>> +
>> + ? ? ? i2c2 {
>> + ? ? ? ? ? ? ? clock-frequency =<400000>;
>> + ? ? ? };
>> +
>> + ? ? ? i2c3 {
>> + ? ? ? ? ? ? ? clock-frequency =<400000>;
>> + ? ? ? };
>> +
>> + ? ? ? i2c4 {
>> + ? ? ? ? ? ? ? clock-frequency =<400000>;
>> + ? ? ? };
>> ? };
>
> Are you sure that this patch is setting the expected frequency?
> I see 100kHz in the boot log even with that patch.
>
> I took me some time to find the proper syntax, but in order to reference an
> existing node, you have to use &i2c1 at the top level of the file. If you
> check the output of the DTC compiler, you will see the property at the
> proper node.

Thanks for bringing this issue. This was one of query I have asked to grant in
one of the e-mail threads. Even I noticed that, it used to fetch default speed
instead of speed assigned in dts file. Let me check with your suggestion.

-Manjunath
