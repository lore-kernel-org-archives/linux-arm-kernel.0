From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 26 Jul 2013 18:55:48 -0300
Subject: [PATCH] ARM: dts: imx53-qsb: Make USBH1 functional
In-Reply-To: <87ehalunfx.fsf@lebrac.rtp-net.org>
References: <1374787113-6628-1-git-send-email-fabio.estevam@freescale.com>
 <87ehalunfx.fsf@lebrac.rtp-net.org>
Message-ID: <CAOMZO5DRd097fKfbnQJY1rtGosnqP5FK=5ZxrzJcH-CSwweWsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On Fri, Jul 26, 2013 at 4:32 PM, Arnaud Patard
<arnaud.patard@rtp-net.org> wrote:
> Fabio Estevam <fabio.estevam@freescale.com> writes:
> Hi,
>
> [...]
>
>> @@ -302,7 +312,9 @@
>>  };
>>
>>  &usbh1 {
>> -       status = "okay";
>> +     vbus-supply = <&reg_usb_vbus>;
>> +     phy_type = "utmi";
>> +     status = "okay";
>>  };
>>
>>  &usbotg {
>
> why not putting the vbus supply on the otg node too ?

I think it would be better to use the otg port as peripheral mode
(after Peter Chen's patches get accepted), so that's why I did not
place the regulatoe into the otg node.

If I recall correctly usb role switch does not work on this board, so
better to use peripheral on otg port and host in USBH1.

Regards,

Fabio Estevam
