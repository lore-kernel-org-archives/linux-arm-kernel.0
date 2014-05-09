From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 09 May 2014 19:53:21 +0200
Subject: [PATCH v2.1 3/9] ARM: S3C24XX: enable usage of common dclk if
 common clock framework is enabled
In-Reply-To: <1399654181.19276.2.camel@x220>
References: <2104342.rkElQpXtvM@phil> <3888936.TSFL3ZW3mv@phil>
 <3835735.0k9HAgQHzN@phil> <1399654181.19276.2.camel@x220>
Message-ID: <536D1611.4010301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.05.2014 18:49, Paul Bolle wrote:
> On Wed, 2014-04-23 at 22:09 +0200, Heiko St?bner wrote:
>> Add platform device and select the correct implementation automatically
>> depending on wether the old samsung_clock or the common clock framework
>> is enabled.
>>
>> This is only done for machines already using the old dclk implementation,
>> as everybody else should move to use dt anyway.
>>
>> The machine-specific settings for the external clocks will have to be set
>> by somebody with knowledge about the specific hardware.
>>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>
> It seems this one just hit linux-next (in next-20140509).
>

Which is bad, because:
a) it conflicts with patches already applied in samsung-clk tree,
b) the DT binding added by patch 4/9 has not been acked .

Kukjin, might I ask you to drop this series from your tree and let me 
send you a pull request with necessary dependencies and this series 
applied properly to resolve merge conflicts, as I suggested before in 
one of my replies to this thread?

Best regards,
Tomasz
