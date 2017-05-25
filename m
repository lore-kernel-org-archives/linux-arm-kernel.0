From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Thu, 25 May 2017 11:06:47 +0300
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: add hi8435 device
In-Reply-To: <20170525070007.GU26102@dragon>
References: <20170522131010.3537-1-nikita.yoush@cogentembedded.com>
 <20170525070007.GU26102@dragon>
Message-ID: <eb86f383-3c27-2276-6213-99c5143420f5@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +&edma1 {
>> +	status = "okay";
>> +};
>> +
>> +&dspi2 {
> 
> Please keep these labelled nodes sort alphabetically.

Ok

>> +	bus-num = <1>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_dspi2>;
>> +	status = "okay";
> 
> We usually have 'status' line at the bottom of property list.

Ok

>> +	spi-num-chipselects = <2>;
>> +
>> +	hi8435 at 1 {
> 
> Node name should be something generic, while label can be specific
> model name.  The following form might be better.
> 
> 	hi8435: sensor at 1

Ok

Although the same file, in lines nearby, has m25p128 at 0 and at93c46d at 1.

Anyway let's delay this a bit, up to the reset polarity description
thing in hi8435 is resolved.

Nikita
