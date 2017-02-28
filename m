From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 28 Feb 2017 11:06:38 +0530
Subject: [PATCH v2 3/3] media: dt-bindings: vpif: new optional property
In-Reply-To: <20170227225209.26oieqwbafqjga2a@rob-hp-laptop>
References: <1487771027-7763-1-git-send-email-bgolaszewski@baylibre.com>
 <1487771027-7763-4-git-send-email-bgolaszewski@baylibre.com>
 <20170227225209.26oieqwbafqjga2a@rob-hp-laptop>
Message-ID: <6b392a4a-2de8-9981-ad40-ca7201bf813d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 February 2017 04:22 AM, Rob Herring wrote:
> On Wed, Feb 22, 2017 at 02:43:47PM +0100, Bartosz Golaszewski wrote:
>> Add an optional property - enable-gpios - which can be used to specify
>> the GPIOs that must be requested to select the vpif functionality.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/media/ti,da850-vpif.txt | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
>> index df7182a..23c5405 100644
>> --- a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
>> +++ b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
>> @@ -13,6 +13,9 @@ Required properties:
>>  - reg: physical base address and length of the registers set for the device;
>>  - interrupts: should contain IRQ line for the VPIF
>>  
>> +Optional properties:
>> +- enable-gpios: phandle of the GPIOs used to select the vpif functionality
> 
> What does this control exactly? The GPIOs belong in the node they are 
> connected to and having GPIOs routed to this block seems strange.

The DA850 EVM board implements on-board muxing which lets the video
input (via VPIF) to be routed to a TVP5147 (video decoder) for composite
input or to a camera header. There are other mux options which use the
same VPIF SoC pins (RMII ethernet or character LCD).

There is a three-to-eight demux on the board which drives enable signals
to buffers letting you choose from these options.

>From your response, it looks like you want the enable-gpios property to
be in the TVP5147 or camera node. That does make sense to me.

>
> There are inputs or outputs?

These GPIOs are driving a 3-to-8 demux so they are all outputs.

Thanks,
Sekhar
