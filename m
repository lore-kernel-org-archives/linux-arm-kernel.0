From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 8 Aug 2016 11:59:25 +0800
Subject: [PATCH 2/2] dt: bindings: Add binding for ESP8089 wifi chips
In-Reply-To: <2936779.FAiO1bqUWV@wuerfel>
References: <1470596269-20572-1-git-send-email-hdegoede@redhat.com>
 <1470596269-20572-2-git-send-email-hdegoede@redhat.com>
 <2936779.FAiO1bqUWV@wuerfel>
Message-ID: <CAGb2v67+QrOxPd4KeLb9F67A0mSaBqn14PynzCyK=ovRnKA6EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Aug 8, 2016 at 3:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday, August 7, 2016 8:57:49 PM CEST Hans de Goede wrote:
>> +Espressif ESP8089 wireless SDIO devices
>> +
>> +This node provides properties for controlling the ESP8089 wireless device.
>> +The node is expected to be specified as a child node to the SDIO controller
>> +that connects the device to the system.
>> +
>> +Required properties:
>> +
>> + - compatible : Should be "esp,esp8089".
>
> I think it would be good to standardize a compatible string for sdio
> like we have it for other discoverable buses, based on the
> vendor/device ID (or whatever this uses), using something like
>
> compatible = "sdio1234,5678", "esp,esp8089";

Is there a central repository for SDIO vendor/device IDs similar to
PCI or USB IDs?

The vendor ID Espressif uses is 0x6666, which seems kind of bogus to me.

ChenYu

>
>> +Optional properties:
>> + - esp,crystal_26M_en: Integer value for the crystal_26M_en firmware parameter
>
> better use '-' instead of '_' for property names.
>
>         Arnd
>
>
