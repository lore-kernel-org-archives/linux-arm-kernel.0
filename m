From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Mar 2016 12:57:49 -0500
Subject: [v6, 3/5] dt: move guts devicetree doc out of powerpc directory
In-Reply-To: <4107975.rId64mooHz@wuerfel>
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-4-git-send-email-yangbo.lu@nxp.com>
 <20160317170640.GB21009@rob-hp-laptop> <4107975.rId64mooHz@wuerfel>
Message-ID: <CAL_JsqL8NkEQx2NoVHSUGYhtNsybCo-yfBCde+_OuMmfwbhYEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 12:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 17 March 2016 12:06:40 Rob Herring wrote:
>> > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt b/Documentation/devicetree/bindings/soc/fsl/guts.txt
>> > similarity index 91%
>> > rename from Documentation/devicetree/bindings/powerpc/fsl/guts.txt
>> > rename to Documentation/devicetree/bindings/soc/fsl/guts.txt
>> > index b71b203..07adca9 100644
>> > --- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
>> > +++ b/Documentation/devicetree/bindings/soc/fsl/guts.txt
>> > @@ -25,6 +25,9 @@ Recommended properties:
>> >   - fsl,liodn-bits : Indicates the number of defined bits in the LIODN
>> >     registers, for those SOCs that have a PAMU device.
>> >
>> > + - little-endian : Indicates that the global utilities block is little
>> > +   endian. The default is big endian.
>>
>> The default is "the native endianness of the system".
>
> This may be what is currently documented, but not what we are doing
> in practice, as there is no "native endianess" for either PowerPC or
> ARM -- both allow running big-endian or little-endian kernels and the
> device registers are fixed.

Notice I said system, not architecture. The way the device registers
are fixed is what I mean by native endianness.

If the purpose of adding this property now is to support GUTS on the
ARM SoCs, then I'd argue using this property is probably wrong. If the
PPC systems are designed with BE device registers and ARM systems with
LE, then this property is not needed.

> I think the property here is fine.

Unless you have studied the FSL ARM based SoCs, then there is not
enough information here to tell.

Rob
