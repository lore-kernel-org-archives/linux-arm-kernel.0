From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 14 Oct 2015 19:26:36 +0800
Subject: [PATCH v4 3/3] arm64: dts: mt8173: Add nor flash node
In-Reply-To: <561E36ED.7090103@cogentembedded.com>
References: <1444729160-26433-1-git-send-email-bayi.cheng@mediatek.com>
 <1444729160-26433-4-git-send-email-bayi.cheng@mediatek.com>
 <561D1642.3070105@cogentembedded.com>
 <CAGS+omDm=74d6cw7kXwkZ_Jy-faBz7z4-vJQX9ZFVNskQqSS-w@mail.gmail.com>
 <561E36ED.7090103@cogentembedded.com>
Message-ID: <CAGS+omDQQ8UDM2pOtU-koz9tfag4SG3Sgf_LrtzsUxeutrTThA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei,

On Wed, Oct 14, 2015 at 7:05 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
> On 10/14/2015 4:07 AM, Daniel Kurtz wrote:
>
>>>> Add Mediatek nor flash node
>>>>
>>>> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
>>>> ---
>>>>    arch/arm64/boot/dts/mediatek/mt8173.dtsi | 15 +++++++++++++++
>>>>    1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>>> b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>>> index d18ee42..385c2e4 100644
>>>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>>> @@ -365,6 +365,21 @@
>>>>                          status = "disabled";
>>>>                  };
>>>>
>>>> +               nor_flash: spi at 1100d000 {
>>>
>>>
>>>     I don't think this is a good label name for a SPI controller.
>>
>>
>> You think "spi" is not a good name for SPI controller?
>> Or you mean the label "nor_flash"?
>
>
>    I think I said clearly: "label". :-)
>
>> Would you prefer:
>>
>>    spi_nor_flash: spi at 1100d000
>
>
>    I'd prefer the "_nor_flash" part to be dropped, to be used for the real
> flash device (if needed) which is a sub-node of this node.

The dedicated nor_flash spi bus cannot just be labeled 'spi', as that
would conflict with the general purpose 'spi' bus.  Instead, it is
given a unique label that can be used as a phandle elsewhere (e.g., in
a board file, to enable the bus).  The name "spi_nor_flash" makes it
clear that this spi bus is only for use for accessing the nor_flash.

Bayi: Actually, this reminds me.  I'd prefer if the bus node was
disabled by default, and only enabled by boards as required.  So, the
node should include:
   status = "disabled";

-Dan
