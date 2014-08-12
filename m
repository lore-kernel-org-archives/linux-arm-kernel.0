From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 12 Aug 2014 20:58:09 +0200
Subject: [PATCH 3/6] ARM: dts: Create cros-tps65090 fragment
In-Reply-To: <CAD=FV=XNsQ_8h-d8epU_gzWRH=A49a8iuirWCUe4TO6VGCvDSw@mail.gmail.com>
References: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>	<1407861868-20097-4-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=XNsQ_8h-d8epU_gzWRH=A49a8iuirWCUe4TO6VGCvDSw@mail.gmail.com>
Message-ID: <53EA63C1.2040302@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

Thanks for your feedback.

On 08/12/2014 07:26 PM, Doug Anderson wrote:
> Javier,
> 
> On Tue, Aug 12, 2014 at 9:44 AM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>> The tps65090 PMU is a component used in many ChromeOS devices
>> so instead of having the same device tree definitions in many
>> files, create a .dtsi fragment that can be included in DTS.
>>
>> This fragment is based on the DT definitions for Peach boards.
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>  arch/arm/boot/dts/cros-tps65090.dtsi | 81 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 81 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/cros-tps65090.dtsi
> 
> I'd probably skip this patch (just have duplication in pit vs. pi), or
> make it "peach" specific (like exynos-peach-tps65090.dtsi?).  This is
> really board-specific info and trying to guess what the various FETs
> are going to be for for all peach variants doesn't seem great.
>

Yes, I guess I went to far on the refactoring with this patch. Most likely I'll
drop the whole series anyway and just add the voltage constraints and parent
supplies to the board DTS, now that Mark explained to me that this refactoring
is actually doing more harm than good.

> -Doug
> 

Best regards,
Javier
