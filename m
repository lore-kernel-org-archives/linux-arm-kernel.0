From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Mon, 19 Jan 2015 14:09:43 +0100
Subject: [PATCH 4/5] PCI: designware: Add setup bus-related to
 pcie_host_ops
In-Reply-To: <000e01d01a7f$47592e20$d60b8a60$%han@samsung.com>
References: <1418812486-12394-1-git-send-email-gabriel.fernandez@linaro.org>
 <1418812486-12394-5-git-send-email-gabriel.fernandez@linaro.org>
 <1507589.aeTeyNn1QF@wuerfel>
 <000e01d01a7f$47592e20$d60b8a60$%han@samsung.com>
Message-ID: <CAG374jBpafrgvSqzmOzUYVNob4OZHT5_EuveD52y+8BRquzXkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Jingoo,

On 18 December 2014 at 05:58, Jingoo Han <jg1.han@samsung.com> wrote:
> On Thursday, December 18, 2014 7:16 AM, Arnd Bergmann wrote:
>> On Wednesday 17 December 2014 11:34:45 Gabriel FERNANDEZ wrote:
>> > ST sti SoCs PCIe IPs are built around DesignWare IP Core.
>> > But in these SoCs PCIe IP doesn't support IO.
>
> Hi Gabriel,
>
> I cannot understand how ST sti SoCs PCIe IP does not support I/O.
> As far as I know, it cannot be selected by the 'parameter'.
> Then, H/W engineers dropped out the I/O control logic?
>
>> >
>> > To support this, add setup_bus() to pcie_host_ops.
>
>
>> >
>> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> > Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>>
>> The dw-pcie driver should be able to tell whether the device has
>> an I/O space or not, and do the right thing based on that. Don't
>> add an implementation specific callback for that.
>
> I agree with Arnd's opinion.
>
> In addition, I have one more question.
> Then, if a device that requires I/O region is connected to
> PCIe slot of ST sti SoCs PCIe, what will happen?
> It just prints error messages?
>
> Best regards,
> Jingoo Han
>
>>
>>       Arnd
>

Arnd in other post mention to add an empty I/O space to workaround
lack of I/O port access.
Is it the right thing to do ?
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/299623.html

Best regards
