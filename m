From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 29 Jan 2014 12:01:42 +0800
Subject: [linux-sunxi] Re: [PATCH RFC 4/6] net: rfkill: gpio: add device
 tree support
In-Reply-To: <20140127142400.GI3867@lukather>
References: <1389941251-32692-1-git-send-email-wens@csie.org>
 <1389941251-32692-5-git-send-email-wens@csie.org>
 <20140127142400.GI3867@lukather>
Message-ID: <CAGb2v65cipUXbL52adDTYLqVJB5gMoDjfWVFa6AYYp0EKvkS6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 27, 2014 at 10:24 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Fri, Jan 17, 2014 at 02:47:29PM +0800, Chen-Yu Tsai wrote:
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  .../devicetree/bindings/rfkill/rfkill-gpio.txt     | 26 ++++++++++++++++++++++
>>  net/rfkill/rfkill-gpio.c                           | 23 +++++++++++++++++++
>>  2 files changed, 49 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/rfkill/rfkill-gpio.txt
>>
>> diff --git a/Documentation/devicetree/bindings/rfkill/rfkill-gpio.txt b/Documentation/devicetree/bindings/rfkill/rfkill-gpio.txt
>> new file mode 100644
>> index 0000000..8a07ea4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rfkill/rfkill-gpio.txt
>> @@ -0,0 +1,26 @@
>> +GPIO controlled RFKILL devices
>> +
>> +Required properties:
>> +- compatible : Must be "rfkill-gpio".
>> +- rfkill-name        : Name of RFKILL device
>> +- rfkill-type        : Type of RFKILL device: 1 for WiFi, 2 for BlueTooth
>> +- NAME_shutdown-gpios        : GPIO phandle to shutdown control
>> +                       (phandle must be the second)
>
> Can't it be handled by a regulator?
>
>> +- NAME_reset-gpios   : GPIO phandle to reset control
>
> And this one using the reset framework?

The driver is already used in platform device and ACPI fashions.
AFAIK, ACPI only passes the GPIO lines. Preferably the behavior
and requirements between the different usages remain the same.


Cheers
ChenYu
