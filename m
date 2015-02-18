From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Wed, 18 Feb 2015 14:33:42 -0500
Subject: amba uarts - arm type uarts fifo size provided by device tree
In-Reply-To: <20150218190601.GI29429@leverpostej>
References: <1424285593-2886-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20150218190601.GI29429@leverpostej>
Message-ID: <54E4E916.1010009@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2015 02:06 PM, Mark Rutland wrote:
> Hi,
>
> Please Cc lakml for patches in this area in future.
>
> On Wed, Feb 18, 2015 at 06:53:11PM +0000, Jorge Ramirez-Ortiz wrote:
>> [PATCH 1/2] Documentation: bindings: add optional fifo size property
>> [PATCH 2/2] drivers/tty: pl011: read fifo size from OF if present
>>
>>
>> These patches aim at resolving an issue present on some of the amba pl011
>> uarts.  
> Which systems are affected? Neither of your two patches add the property
> to any dts file.


yes, the system affected is still under revision (I should have mentioned)
https://lkml.org/lkml/2015/2/5/144

this is the board I am using to test
https://www.96boards.org/products/hikey/

>
>> Some of these arm type uarts have their fifo sizes not defined in terms of the
>> amba_rev register. 
> What does said register actually contain?

the amba_rev contains '1' for the Hisilicon Hi6220 SoC

>
> Is this a full PL011, or a cut-down SBSA UART?

I believe is full PL011 (ARM type) - that is what is being run in my tests.

>
> Mark.
>
>> Those uarts should be able to declare their fifo sizes using the optional
>> property "fifo-size" in the device tree. This device tree setting shall take
>> precedence over any other values. 
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
