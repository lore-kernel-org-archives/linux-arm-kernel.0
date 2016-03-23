From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 23 Mar 2016 11:10:06 -0700
Subject: [PATCH v2 0/6] ARM64: meson: GXBaby (S905) and Vega S95 enablement
In-Reply-To: <56F1AB26.8050200@suse.de> ("Andreas =?utf-8?Q?F=C3=A4rber=22?=
 =?utf-8?Q?'s?= message of "Tue, 22 Mar 2016 21:29:26 +0100")
References: <1456886101-22967-1-git-send-email-afaerber@suse.de>
 <CAOi56cXFEUZuu0bJknUYNhfR2jL=LYUTbpnX9diZw2B5JfTaEQ@mail.gmail.com>
 <56F1AB26.8050200@suse.de>
Message-ID: <7hoaa5qd4x.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas F?rber <afaerber@suse.de> writes:

> Am 21.03.2016 um 23:36 schrieb Kevin Hilman:
>> On Tue, Mar 1, 2016 at 6:34 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> 
>>> Note: On the Vega S95 I need to change TEXT_OFFSET as follows,
>>> in order to avoid the vendor U-Boot overwriting itself (fwiu);
>>> for the Mini Mx that's reportedly not necessary.
>> 
>> FYI, the Amlogic P200 dev board also needs this hack with the factory u-boot.
>
> I have meanwhile found that
>
> mkimage -A arm64 -O linux -T kernel -C none -a 0x1080000 -e 0x1080000 \
> -n linux-next -d arch/arm64/boot/Image ../uImage
>
> and then using bootm instead of booti works even without the above hack
> on the Vega S95. Not a satisfactory solution yet, but better than
> patching the kernel in a distro-incompatible way.

Thanks for sharing.  I can confirm this is working for me too.

Kevin
