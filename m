From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Jun 2014 16:57:11 -0600
Subject: [PATCH 2/4] of: Add NVIDIA Tegra XUSB pad controller binding
In-Reply-To: <20140605220833.GA28817@ulmo>
References: <1401894990-30092-1-git-send-email-thierry.reding@gmail.com>
 <1401894990-30092-2-git-send-email-thierry.reding@gmail.com>
 <53909F31.4050603@wwwdotorg.org> <20140605220833.GA28817@ulmo>
Message-ID: <5390F5C7.5070301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2014 04:08 PM, Thierry Reding wrote:
> On Thu, Jun 05, 2014 at 10:47:45AM -0600, Stephen Warren wrote:
>> On 06/04/2014 09:16 AM, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> This patch adds the device tree binding documentation for the XUSB pad
>>> controller found on NVIDIA Tegra SoCs. It exposes both pinmuxing and PHY
>>> capabilities.
>>
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
>>
>>> +- #phy-cells: Should be 1. The specifier is the index of the PHY to reference.
>>> +  Possible values are:
>>> +  - 0: PCIe
>>> +  - 1: SATA
>>
>> Those values are defined in
>> include/dt-bindings/pinctrl/pinctrl-tegra-xusb.h. I personally consider
>> the <dt-bindings/> header files to be part of the binding itself, rather
>> than being derived from the binding. As such, I'd suggest the following
>> changes:
>>
>> * Make this patch 1 not patch 2
>> * Move pinctrl-tegra-xusb.h into this patch.
>> * Remove the list of values above, and replace it with the text "See
>> <dt-bindings/pinctrl/pinctrl-tegra-xusb.h> for the set of valid values".
> 
> I remember discussions where people explicitly said that relying on the
> symbolic names in the DT bindings was a mistake because it would mean
> that everyone would need to have access to a mechanism similar to what
> we have in the Linux kernel (and that the header files would always need
> to be shipped with the DT bindings).

The entire point of the headers is so that the binding definitions and
code using them can't get out of sync. In my opinion, the headers *are*
part of the bindings, so of course anyone either reading DT bindings, or
parsing DT, must have the headers, and hence the headers must be bundled
with the DT files or with the bindings wherever they go.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140605/2628de6b/attachment.sig>
