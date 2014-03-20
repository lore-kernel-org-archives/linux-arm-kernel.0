From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 20 Mar 2014 14:32:18 +0100
Subject: [PATCH] ASoC: tda998x: Fix lack of required reg in DT
 documentation
In-Reply-To: <20140320140156.5d768b1f@armhf>
References: <20140320092639.48F68A6279@smtp3-g21.free.fr>
 <532ADFD8.80301@gmail.com> <20140320140156.5d768b1f@armhf>
Message-ID: <532AEDE2.3080306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2014 02:01 PM, Jean-Francois Moine wrote:
> On Thu, 20 Mar 2014 13:32:24 +0100
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>
>>> +  - reg: I2C address - must be <0x70>
>>
>> TDA9983b datasheet says:
>>
>> "Bits A0 and A1 of the I2C-bus device address are externally selected
>> by pins A0 and A1."
>>
>> Therefore, 0x70, 0x71, 0x72, and 0x73 are valid i2c addresses.
>
> Sebastian,
>
> That's interesting!
>
> For the Cubox and the AMX33XX boards, the I2C address of the HDMI
> registers is 0x70, and the I2C address of the CEC registers is 0x34.
>
> For other boards using the TDA998x family, if the I2C address is
> different from 0x70, have you an idea about what can be the CEC I2C
> address? (this value is actually hard-coded in the TDA998x driver)
>

Ok, I had another round of google'ing and found this:
http://hipstercircuits.com/wp-content/uploads/2013/05/TDA19988.pdf

There, the datasheet specifically for TDA19988 only states 0x70 and
0x34 as the two i2c addresses. Therefore, TDA19988 has fixed i2c
addresses while TDA9983b has configurable (main) i2c address.

Not as easy as we thought ;)

I suggest reword the reg property to:
"- reg: shall be set to the I2C address"

and optionally list all known addresses for each TDA[1]998x in the
binding.

Sebastian
