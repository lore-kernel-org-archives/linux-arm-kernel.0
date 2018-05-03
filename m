From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 3 May 2018 21:01:26 +0200
Subject: [PATCH v3] arm: exynos/s3c: dts: Remove leading 0x and 0s from
 bindings notation
In-Reply-To: <CA+7wUswQDXZTXWFd=mwo8ehFxHkOp0UA-RuO_fVBzoj-7mutSg@mail.gmail.com>
References: <20180502201153.7459-1-malat@debian.org>
 <20180503184454.19131-1-malat@debian.org>
 <20180503185342.zawmhazzvkkdc3ja@kozik-lap>
 <CA+7wUswQDXZTXWFd=mwo8ehFxHkOp0UA-RuO_fVBzoj-7mutSg@mail.gmail.com>
Message-ID: <CAJKOXPdB7rtdC_S+oP=Q=vfgF5ssMSHivXhQYz9p9i3Aw=ZAMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 3, 2018 at 8:58 PM, Mathieu Malaterre <malat@debian.org> wrote:
> On Thu, May 3, 2018 at 8:53 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On Thu, May 03, 2018 at 08:44:53PM +0200, Mathieu Malaterre wrote:
>>> Improve the DTS files by removing all the leading "0x" and zeros to fix the
>>> following dtc warnings:
>>>
>>> Warning (unit_address_format): Node /XXX unit name should not have leading "0x"
>>>
>>> and
>>>
>>> Warning (unit_address_format): Node /XXX unit name should not have leading 0s
>>>
>>> Converted using the following command:
>>>
>>> find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed  -i -e "s/@\([0-9a-fA-FxX\.;:#]\+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0\+\(.*\) {/@\1 {/g" {} +
>>
>> The firmware node is fixed but in my case the command is doing much
>> more:
>
> Looks like I cannot copy/paste correctly, meant to say:
>
> find . -type f \( -iname "*.dts" -o -iname "*.dtsi" \) -exec sed  -i
> -e "s/@\([0-9a-fA-FxX\.;:#]\+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1
> {/g" -e "s/@0\+\(.\+\) {/@\1 {/g" {} +

I split it with backslash and this worked fine. I'll update the commit
message, thanks!

BR,
Krzysztof
