From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 29 Aug 2016 12:50:18 -0500
Subject: [PATCH v2] ARM64: dts: amlogic: Add basic support for Amlogic
 S905X
In-Reply-To: <m2y43fii28.fsf@baylibre.com>
References: <1472382113-10754-1-git-send-email-carlo@caione.org>
 <m2y43fii28.fsf@baylibre.com>
Message-ID: <CAOi56cW3rRVbLM9L=aCMQSsYvuXQBOKdEY4LqN0NBpbm3Lzz+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 12:46 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Carlo Caione <carlo@caione.org> writes:
>
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> This patch introduces the basic support for the Amlogic S905X (Meson
>> GXL) and for the Amlogic evaluation board P212.
>> No documentation has been released yet for this SoC, so for now only the
>> bare minimum has been added in the DT.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Andreas F?rber <afaerber@suse.de>
>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>> ---
>>
>> Hey Kevin,
>> Can you take this one?
>>
>> Changelog:
>> v2:
>>   - Added acked-by and reviewed-by
>>
>> ---
>>  Documentation/devicetree/bindings/arm/amlogic.txt |   5 +
>>  arch/arm64/boot/dts/amlogic/Makefile              |   1 +
>>  arch/arm64/boot/dts/amlogic/meson-gxl-p212.dts    |  70 +++++++++
>>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi        | 179 ++++++++++++++++++++++
>
> It seems to me that meson-gxl.dtsi is almost identicial to
> meson-gxbb.dtsi.  I think we should create another .dtsi for all the
> common parts.  Something like meson-gx-common.dtsi, which is included
> by meson-gxbb.dtsi and meson-gxl.dtsi
>
> Also, the GXL family has both the S905x and S905D SoCs, so we may need
> meson-gxl-s905x.dtsi and meson-gxl-s905d.dtsi but I'm not sure of the
> full set of differences between those, so we can save that for later.
>
> But, I do think the board files should probably have the SoC name.  So
> they would look something like: meson-gxl-s905x-p212.dts (which you
> have) and meson-gxl-s905d-p230.dts (which I have.)

Oops, I should've read a bit more of my backlog before responding
here.  I see Neil has already done this building on your patch.

Kevin (still catching up on post-holiday mails)
