From: xuejiancheng@huawei.com (xuejiancheng)
Date: Mon, 11 Jan 2016 10:05:57 +0800
Subject: [PATCH v5 6/6] ARM: dts: add dts files for Hi3519
In-Reply-To: <20160108151058.GN19062@n2100.arm.linux.org.uk>
References: <1452219400-32478-1-git-send-email-xuejiancheng@huawei.com>
 <1452219400-32478-7-git-send-email-xuejiancheng@huawei.com>
 <20160108151058.GN19062@n2100.arm.linux.org.uk>
Message-ID: <56930E05.1050009@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On 2016/1/8 23:10, Russell King - ARM Linux wrote:
> On Fri, Jan 08, 2016 at 10:16:40AM +0800, Jiancheng Xue wrote:
>> +		uart0: serial at 12100000 {
>> +			compatible = "arm,pl011", "arm,primecell";
>> +			reg = <0x12100000 0x1000>;
>> +			interrupts = <0 4 4>;
> 
> Should the last digit there be IRQ_TYPE_LEVEL_HIGH (and same for the
> other interrupts= after this?)
> 
> Thanks.
> 

I'll include <dt-bindings/interrupt-controller/arm-gic.h> and use
IRQ_TYPE_LEVEL_HIGH instead. The interrupts specifier will be wrote
like this "interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;".

Thank you.

Jiancheng
