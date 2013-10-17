From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 17 Oct 2013 10:50:36 +0100
Subject: [RFC PATCH 4/5] ARM: psci: Add support for system reboot and
 poweroff
In-Reply-To: <CAAhSdy3VdRnuGEMzeDrAigkD=FM+rp4VL9yC+QVaRaJRAbEunQ@mail.gmail.com>
References: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
 <1381942954-22388-5-git-send-email-anup.patel@linaro.org>
 <525F1074.8000208@gmail.com>
 <CAAhSdy3VdRnuGEMzeDrAigkD=FM+rp4VL9yC+QVaRaJRAbEunQ@mail.gmail.com>
Message-ID: <525FB2EC.4010406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/13 06:08, Anup Patel wrote:
> On Thu, Oct 17, 2013 at 3:47 AM, Rob Herring <robherring2@gmail.com> wrote:
>> On 10/16/2013 12:02 PM, Anup Patel wrote:
>>> We have PSCI SYSTEM_OFF and SYSTEM_RESET function call emulation
>>> available when running as Guest using KVM ARM.
>>>
>>> This patch implements system reboot and poweroff using PSCI
>>> SYSTEM_OFF and SYSTEM_RESET.
>>
>> I've done a similar patch [1] which also needs binding documentation to
>> go with it. The last version of which there is no agreement on is here [2].
>>
>> Rob
>>
>> [1] http://www.spinics.net/lists/arm-kernel/msg262217.html
>> [2] http://www.spinics.net/lists/devicetree/msg05348.html
> 
> Thanks, for the early warning.
> 
> I would be happy to go with your patch since you have already the device tree
> bindings covered.
> 
> IMHO, we should try to go ahead with existing scheme of PSCI device tree
> bindings for SYSTEM_OFF and SYSTEM_RESET. Later anyone can propose
> revised PSCI device tree bindings. Its not nice to hold off good changes just
> because people don't agree on the device tree bindings.

*Shrug*

DT is an ABI. Even more for virtualization. It can't be revised without
keeping the old version alive. Once it is in, it is for good, and we
have support it forever. So we'd better get it right from the beginning,
no matter how long it takes.

	M.
-- 
Jazz is not dead. It just smells funny...
