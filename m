From: carlo@caione.org (Carlo Caione)
Date: Wed, 23 Mar 2016 09:06:23 +0100
Subject: [PATCH v2 0/6] ARM64: meson: GXBaby (S905) and Vega S95 enablement
In-Reply-To: <56F1AB26.8050200@suse.de>
References: <1456886101-22967-1-git-send-email-afaerber@suse.de>
 <CAOi56cXFEUZuu0bJknUYNhfR2jL=LYUTbpnX9diZw2B5JfTaEQ@mail.gmail.com>
 <56F1AB26.8050200@suse.de>
Message-ID: <CAOQ7t2aB6X5gS+0RfyB1PjTpJnUFnF95ejXwhYXgxEmXSq0KFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 9:29 PM, Andreas F?rber <afaerber@suse.de> wrote:
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

I wonder if we can add this kind of information in Documentation/arm/meson/.
Probably it could be handy until we have a proper u-boot porting.

-- 
Carlo Caione
