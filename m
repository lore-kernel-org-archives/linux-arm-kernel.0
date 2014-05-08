From: ipaton0@gmail.com (Iain Paton)
Date: Thu, 08 May 2014 20:27:55 +0100
Subject: [PATCH v2] ARM: dts: imx6: add new board RIoTboard
In-Reply-To: <1399570376.88508577@f371.i.mail.ru>
References: <53695C34.5000604@gmail.com> <1399560632.547109991@f294.i.mail.ru>
 <536BBAE2.7060203@gmail.com> <1399570376.88508577@f371.i.mail.ru>
Message-ID: <536BDABB.7090101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/14 18:32, Alexander Shiyan wrote:
> Thu, 08 May 2014 18:12:02 +0100 ?? Iain Paton <ipaton0@gmail.com>:
>> +&aips2 {
>> +        i2c4: i2c at 021f8000 {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +                compatible = "fsl,imx1-i2c";
> 
> Are you sure about use "fsl,imx1-i2c" instead of  "fsl,imx21-i2c"?
> In any case you should add "fsl-imx6dl-i2c" as first compatible string.
> The rest looks good.

Sure?  No.  However that's what currently exists in imx6dl.dtsi for i2c4.

looking at the other i2c interfaces in imx6qdl.dtsi, they're using
fsl,imx6q-i2c as the first compatible string. So I think I should use
either fsl,imx6dl-i2c or fsl,imx6q-i2c. 
What's the difference between that and your suggested fsl-imx6dl-i2c?
If we assume can assume the i2c4 block is functionally identical to
i2c[123] then shouldn't I use an identical compatible string?

The driver has the following compatible strings:
fsl,imx1-i2c
fsl,imx21-i2c
fsl,vf610-i2c

the difference between imx1-i2c and imx21-i2c seems to be an added delay
before generating the stop bit to workaround a hardware bug.

As it seems likely I'm the first to be trying to enable i2c4 I'd want to
check that the hardware bug doesn't apply here and that there's no 
negative effect. 
I think you're probably correct and I should change it, but I'll do the 
tests anyway and post the series if I don't see any problems.

Thanks,
Iain
