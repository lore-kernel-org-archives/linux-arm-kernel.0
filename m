From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 25 Oct 2014 20:51:33 +0200
Subject: [PATCH v2] arm: dts: add initial support for TBS2910 Matrix ARM
 mini PC
In-Reply-To: <544BE2E6.4040903@web.de>
References: <1413635236-3825-1-git-send-email-smoch@web.de>
 <1413922998-4371-1-git-send-email-smoch@web.de> <20141025153321.GA5321@tiger>
 <544BE2E6.4040903@web.de>
Message-ID: <544BF135.4030503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.10.2014 19:50, Soeren Moch wrote:
> thanks for your comments.
>>
>> Very neat patch! A couple of minor comments below ...
>>
>> On Tue, Oct 21, 2014 at 10:23:18PM +0200, Soeren Moch wrote:
>>> TBS2910 is a i.MX6Q based board. For additional details refer to
>>> http://www.tbsdtv.com/products/tbs2910-matrix-arm-mini-pc.html
>>>
>>> Reviewed-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>> Signed-off-by: Soeren Moch <smoch@web.de>
>>> ---
>>> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>> Cc: Shawn Guo <shawn.guo@linaro.org>
>>> Cc: Sascha Hauer <kernel@pengutronix.de>
>>>
>>> Changes for v2:
>>> - add tbs vendor prefix to vendor-prefixes.txt
>>> - use GPIO_ACTIVE_{HIGH,LOW}
>>> - add led label and default-state="keep"
>>> - whitespace cleanup
>>> ---
>>>   .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>>
>> This is not an i.MX change.  It should go through DT tree or we need
>> an ACK from DT maintainers.
>
> This was not part of the original patch and came in due to review
> comments. If it is not required I can remove it.
>
> If you suggest some other way to handle this, was exactly should I do?
> I'm not very experienced in kernel development.

Split the changes for vendor-prefixes.txt into a separate patch.
When you resend, run ./scripts/get_maintainer.pl on each of the
patches. It will give you people and lists to put into Cc (you can
leave out committers, make sure to add Maintainers and the
corresponding lists).

Once read by a DT maintainer, he will either pick it up or give an
Acked-by.

[...]
>>> diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
>>> new file mode 100644
>>> index 0000000..60a91ee
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
>>> @@ -0,0 +1,415 @@
>>> +/*
>>> + * Copyright 2014 Soeren Moch <smoch@web.de>
>>> + * Copyright 2012 Freescale Semiconductor, Inc.
>>> + * Copyright 2011 Linaro Ltd.
>>> + *
>>> + * The code contained herein is licensed under the GNU General Public
>>> + * License. You may obtain a copy of the GNU General Public License
>>> + * Version 2 or later at the following locations:
>>> + *
>>> + * http://www.opensource.org/licenses/gpl-license.html
>>> + * http://www.gnu.org/copyleft/gpl.html
>>> + */
[...]
>>> +	rtc: ds1307 at 68 {
>>> +		compatible = "dallas,ds1307";
>>> +		reg = <0x68>;
>>> +	};
>>> +};
>>> +
>>> +&iomuxc {
>>
>> We do sort nodes alphabetically, but this one is a little special.
>> Moving it to the bottom of the file will slightly improve the
>> readability of the file.
>
> OK, I will move this node to the bottom.
>
> When talking about readability, in my original patch I used spaces to
> align the pin configuration values to preserve human readability while
> obeying the line length limits. Is it really desired to drop human
> readability in favor of avoiding spaces?

IIRC, there has been no strict 80-column rule for dts{i} files in the
past. In general, I'd prefer readability before 80-column rule if it is
just about some few chars. But that is a matter of taste, I guess.

BTW, the comment I made about indentation on your patch was about
<TAB><TAB><SPACES> instead of <TAB><TAB><TAB> in blue led node. I agree
that once you reached the property indent with TABs, use spaces to align
multi-line properties for readability.

Sebastian
