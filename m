From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Tue, 8 Mar 2016 23:07:35 +0700
Subject: linux-next: manual merge of the watchdog tree with the arm-soc
 tree
In-Reply-To: <56DEF871.8050102@arm.com>
References: <20160307150402.191ba735@canb.auug.org.au>
 <56DEF546.9090900@arm.com> <56DEF871.8050102@arm.com>
Message-ID: <56DEF8C7.9000409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/16 23:06, Sudeep Holla wrote:

Hi Sudeep,

> On 08/03/16 15:52, Andr? Przywara wrote:
>> On 07/03/16 11:04, Stephen Rothwell wrote:
>>> Hi Wim,
>>>
>>> Today's linux-next merge of the watchdog tree got a conflict in:
>>>
>>>    arch/arm64/boot/dts/arm/foundation-v8.dts
>>>
>>> between commit:
>>>
>>>    d11a89796678 ("arm64: dts: split Foundation model dts to put the
>>> GIC separately")
>>>
>>> from the arm-soc tree and commit:
>>>
>>>    fe3a97e8ed02 ("ARM64: add SBSA Generic Watchdog device node in
>>> foundation-v8.dts")
>>>
>>> from the watchdog tree.
>>>
>>> I fixed it up (see below) and can carry the fix as necessary (no action
>>> is required).
>>
>> But unfortunately this is the wrong solution. The watchdog DT node
>> belongs into the (newly created) common foundation-v8.dtsi, not into the
>> GICv2-only .dts.
>> So whoever now provides the watchdog patch, can it be rebased on top of
>> the foundation model .dts rework, so that the new node ends up in the
>> .dtsi file?
>> If this is too much hassle I could also send a fix after -rc1 (as the
>> breakage is not really critical).
>>
> 
> I have rebased it on top of my earlier PR and sending it shortly.
> I have moved it to dtsi file.

Thanks, that was quick!

Hope that this now does not collide with Fu Wei's fix ;-)

Cheers,
Andre.
