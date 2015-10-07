From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 7 Oct 2015 08:47:15 +0200
Subject: [PATCH] ARM: bcm2835: add label for uart0
In-Reply-To: <561482CE.2020804@wwwdotorg.org>
References: <1443810675-25558-1-git-send-email-stefan.wahren@i2se.com>
 <87oagbhdfb.fsf@eliezer.anholt.net> <561482CE.2020804@wwwdotorg.org>
Message-ID: <5614BFF3.9010708@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.10.2015 um 04:26 schrieb Stephen Warren:
> On 10/06/2015 03:53 PM, Eric Anholt wrote:
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>
>>> This patch adds a label for uart0 to allow changing of uart0
>>> pins.
>>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> This patch seems innocuous, but could you clarify for me how
>> exactly you change the uart0 pins, and why one would do that?
> I /assume/ this is so that some other DT file (that includes the
> edited file) can add some pinctrl-related properties to this DT node,
> using syntax such as:
>
> &uart0 {
>     new content;
> };
>
> If so, the patch,
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>

Your assumption is correct. In case the UART should be used on a custom
board with Raspberry Pi Compute Module and a microcontroller this change
is necessary to reference the UART:

&gpio {
  // ...

  uart0_pins: uart0_pins {
    brcm,pins = <36 37>;
    brcm,function = <BCM2835_FSEL_ALT2>;
  };
}

&uart0 {
  pinctrl-names = "default";
  pinctrl-0 = <&uart0_pins>;
  status = "okay";
};

Thanks

Stefan
