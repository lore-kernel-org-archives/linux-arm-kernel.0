From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 27 Aug 2014 10:42:19 -0600
Subject: [PATCH v2 3/9] of: Update Tegra XUSB pad controller binding for
 USB
In-Reply-To: <CAL1qeaGHuMegpeyumD8GrFRmeufkiiUygAdqu1ECHrfSkixwOQ@mail.gmail.com>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>	<1408381705-3623-4-git-send-email-abrestic@chromium.org>	<53FB8A8C.8040107@wwwdotorg.org>
 <CAL1qeaGHuMegpeyumD8GrFRmeufkiiUygAdqu1ECHrfSkixwOQ@mail.gmail.com>
Message-ID: <53FE0A6B.8000607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2014 10:36 AM, Andrew Bresticker wrote:
> On Mon, Aug 25, 2014 at 12:12 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
>>>    - #phy-cells: Should be 1. The specifier is the index of the PHY to
>>> reference.
>>>      See <dt-bindings/pinctrl/pinctrl-tegra-xusb.h> for the list of valid
>>> values.
>>> +- mboxes: Must contain an entry for the XUSB PHY mailbox channel.
>>> +  See ../mailbox/mailbox.txt for details.
>>
>>
>> Can we require the mbox-names property here, so that everything is looked up
>> by names. I know that the proposed mbox binding states that using indexes is
>> preferred over names, but that's just silly considering that names are
>> widely used in most other similar bindings, and are much easier to extend in
>> a backwards compatible fashion in the face of optional entries. As such, I'd
>> prefer that all Tegra bindings use foo-names properties where they exist.
>
> Sure, will do.
>
>>> +Optional properties:
>>> +-------------------
>>> +- vbus-otg-{0,1,2}-supply: VBUS regulator for the corresponding UTMI pad.
>>
>>
>> Why "-otg"? It's quite possible to have a regulator for VBUS even on systems
>> that don't support OTG, but rather simply have the ability to turn VBUS off.
>
> Because they're the VBUS supplies for the OTG 'lanes'.  It doesn't
> really add anything, so I'll omit the "-otg".

Ah right. In that case, if the lanes are named "OTG" lanes in the HW 
docs, I'm happy either way. If you did decide to keep the "-otg", 
rewording as "VBUS regulator for the corresponding OTG UTMI pad" would 
make the meaning clearer.
