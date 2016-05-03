From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 3 May 2016 12:45:07 -0300
Subject: [PATCH] ARM: dts: imx: Remove unneeded unit-addresses
In-Reply-To: <CAOMZO5AO15UmNJARS9aL-U=CjYnUq0D9S38NYHC8w2DLwOeR_A@mail.gmail.com>
References: <1462283851-10820-1-git-send-email-fabio.estevam@nxp.com>
 <CAL_JsqKv_7ufFG7DSkxqp9QOEjLEDVofyYMoudtJjqBA78ahcA@mail.gmail.com>
 <CAOMZO5AO15UmNJARS9aL-U=CjYnUq0D9S38NYHC8w2DLwOeR_A@mail.gmail.com>
Message-ID: <CAOMZO5BXFL47p=WTPDDRFGq38yktmB1FnbOTWJ37mrWsKkeUSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 12:42 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, May 3, 2016 at 12:37 PM, Rob Herring <robh@kernel.org> wrote:
>
>> Presumably these are register offsets which could be useful to have
>> even if the Linux driver doesn't use them. But either way is fine with
>> me.
>
> Yes, these are register offsets.
>
>                 reg_3p0: regulator-3p0 {
>                     compatible = "fsl,anatop-regulator";
>                     regulator-name = "vdd3p0";
>                     regulator-min-microvolt = <2625000>;
>                     regulator-max-microvolt = <3400000>;
>                     anatop-reg-offset = <0x120>;

Sorry, pressed the 'send' button too quickly.

There is a "anatop-reg-offset = <0x120>;" property that is used to
pass the offset to the anatop regulator driver, so that's why I
preferred to remove the unneeded unit-address.

Thanks
