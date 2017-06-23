From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 23 Jun 2017 12:46:09 +0200
Subject: [PATCH v1 1/6] DT bindings: add bindings for ov965x camera module
In-Reply-To: <D5629236-95D8-45B6-9719-E8B9796FEC90@goldelico.com>
References: <1498143942-12682-1-git-send-email-hugues.fruchet@st.com>
 <1498143942-12682-2-git-send-email-hugues.fruchet@st.com>
 <D5629236-95D8-45B6-9719-E8B9796FEC90@goldelico.com>
Message-ID: <d14b8c6e-b480-36f0-ed0a-684647617dbe@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 23.06.2017 um 12:25 schrieb H. Nikolaus Schaller:
>> diff --git a/Documentation/devicetree/bindings/media/i2c/ov965x.txt b/Documentation/devicetree/bindings/media/i2c/ov965x.txt
>> new file mode 100644
>> index 0000000..0e0de1f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/i2c/ov965x.txt
>> @@ -0,0 +1,37 @@
>> +* Omnivision OV9650/9652/9655 CMOS sensor
>> +
>> +The Omnivision OV965x sensor support multiple resolutions output, such as
>> +CIF, SVGA, UXGA. It also can support YUV422/420, RGB565/555 or raw RGB
>> +output format.
>> +
>> +Required Properties:
>> +- compatible: should be one of
>> +	"ovti,ov9650"
>> +	"ovti,ov9652"
>> +	"ovti,ov9655"
>> +- clocks: reference to the mclk input clock.
> 
> I wonder why you have removed the clock-frequency property?
> 
> In some situations the camera driver must be able to tell the clock source
> which frequency it wants to see.

That's what assigned-clock-rates property is for:

https://www.kernel.org/doc/Documentation/devicetree/bindings/clock/clock-bindings.txt

AFAIU clock-frequency on devices is deprecated and equivalent to having
a clocks property pointing to a fixed-clock, which is different from a
clock with varying rate.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
