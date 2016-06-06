From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 6 Jun 2016 15:05:51 +0800
Subject: [PATCH 1/3] ARM: dts: sun4i: The blue led on the Mele A1000 is a
 power led
In-Reply-To: <CAGb2v66iYcOCSbX6Q9OLFYaaCpzqRC94v+OXfd8gcD7GG1eZRg@mail.gmail.com>
References: <1465129393-22379-1-git-send-email-hdegoede@redhat.com>
 <CAGb2v66iYcOCSbX6Q9OLFYaaCpzqRC94v+OXfd8gcD7GG1eZRg@mail.gmail.com>
Message-ID: <CAGb2v66nnStG-JUwgPpiSsde0kbfeL5m-OfpmDNornhiMrhm7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 6, 2016 at 3:01 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Sun, Jun 5, 2016 at 8:23 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The blue led on the Mele A1000 is wired to light up as soon as the board
>> has powered (it will be on while the gpio is still in input / floating
>> mode), also its location on the top-set box clearly signals "power led".
>>
>> Until now we've been treating this as a generic usr function led, which
>> means that when you plug power into the top-set box, the power-led lights
>> and then turns off as soon as the kernel loads, which looks wrong.
>>
>> This renames the led from a1000:blue:usr to a1000:blue:pwr and marks
>> it as default on, fixing this.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

BTW, the kernel now supports using an LED as a panic indicator.
Would it be useful to use the power LED for this?

ChenYu
