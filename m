From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 01 Mar 2015 23:50:45 +0300
Subject: [PATCH v3 1/2] dts: vt8500: Add SDHC node to DTS file for WM8650
In-Reply-To: <20150301224959.4a106bfd@v1ron-s7>
References: <1423130878-3894-1-git-send-email-v1ron@v1ros.org>	<1425226007-2757-1-git-send-email-rvolkov@v1ros.org>	<1425226007-2757-2-git-send-email-rvolkov@v1ros.org>	<54F35371.7020608@cogentembedded.com>
 <20150301224959.4a106bfd@v1ron-s7>
Message-ID: <54F37BA5.2080605@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/01/2015 10:49 PM, Roman Volkov wrote:

>>> Since WM8650 has the same 'WMT' SDHC controller as WM8505, and the
>>> driver is already in the kernel, this node enables the controller
>>> support for WM8650

>>> Signed-off-by: Roman Volkov <rvolkov@v1ros.org>
>>> Reviewed-by: Alexey Charkov <alchark@gmail.com>
>>> ---
>>>    arch/arm/boot/dts/wm8650.dtsi | 9 +++++++++
>>>    1 file changed, 9 insertions(+)

>>> diff --git a/arch/arm/boot/dts/wm8650.dtsi
>>> b/arch/arm/boot/dts/wm8650.dtsi index b1c59a7..e12213d 100644
>>> --- a/arch/arm/boot/dts/wm8650.dtsi
>>> +++ b/arch/arm/boot/dts/wm8650.dtsi
>>> @@ -187,6 +187,15 @@
>>>    			interrupts = <43>;
>>>    		};
>>>
>>> +		sdhc at d800a000 {

>>      According to the ePAPR standard, the device nodes should have
>> generic names according to their functions, so this node should be
>> named just "sd at d800a000".

>> WBR, Sergei

> Sergei,

> Why not "sdmmc" or "sdhci" or "sdio" then? It would be great to name

    SDHCI is the SD host controller standard, while the names should describe 
"the function of the device and not its precise programming model". SDIO isn't 
the physical interface name, the physical interface underneath is still SD. 
"mmcsd" or "mmc-sd" would be appropriate, however just "mmc" is typically used.

> nodes in same way, but there is no exact requirement in ePAPR v1.1
> regarding SD/MMC controllers.

    Yes, MMC/SD node names are not yet standardized.

> Also, in Linux I don't see that someone
> strictly follows this requirement.

    Because people for the most part are not aware of it, despite 
http://www.devicetree.org/Device_Tree_Usage points to ePAPR and the section 
2.4 of this page also tells to use generic names.

> This renaming will affect driver,
> since .compatible strings likely also need changing.

    Why on earth they'll need change?!

> Roman

WBR, Sergei
