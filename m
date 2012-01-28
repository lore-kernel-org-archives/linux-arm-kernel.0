From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Sat, 28 Jan 2012 12:19:05 +0530
Subject: [alsa-devel] [PATCH v4 - resend 00/13] OMAP4: ASoC: Support for
 PandaBoard family
In-Reply-To: <CAAURCh7u=3KLNKfK_YYkVJ_i8azQ=oV0ugVxYvi=thhoLdGEJQ@mail.gmail.com>
References: <1327405950-6676-1-git-send-email-peter.ujfalusi@ti.com>
 <CAJe_Zhfn3urdXfRgAKvdW2_ECYGbNO0b2BuZnCZxrGcL4_sVSg@mail.gmail.com>
 <CAAURCh7u=3KLNKfK_YYkVJ_i8azQ=oV0ugVxYvi=thhoLdGEJQ@mail.gmail.com>
Message-ID: <CAJe_Zhfo_Z7p4P3Lxj1OyEGWU-EMMRk35qJQ2R1Jwsey9+gOSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastien,

On 28 January 2012 04:21, Guiriec, Sebastien <s-guiriec@ti.com> wrote:
>>>
>> Hi Peter,
>> ? ? I tried the patchset on my 4430 Panda. Playback works ok, but not Capture.
>> All is get is a hiss.
>> ? ?Is capture supposed to work ? If yes, any amixer settings that need
>> to be done?
>
> Hi Jassi,
>
> With the next update the PandaBoard 4430 is working fine.
> cpu_is_omap4430() macro is not define. We should use cpu_is_omap443x()
> macro in order to select correctly PandaBoard and not PandaBoardES
> board. Due to this error the heaset Mic pin is not enable so record is not
> working (use for Panda 4430 recording).
>
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-
> omap2/board-omap4panda.c
> index 5f27387..6a397e9 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -580,7 +580,7 @@ void omap4_panda_display_init(void)
>
> ?static void omap4_panda_init_rev(void)
> ?{
> - ? ? ? if (cpu_is_omap4430()) {
> + ? ? ? if (cpu_is_omap443x()) {
> ? ? ? ? ? ? ? ?/* PandaBoard 4430 */
> ? ? ? ? ? ? ? ?/* ASoC audio configuration */
> ? ? ? ? ? ? ? ?panda_abe_audio_data.card_name = "PandaBoard";
>
Thanks, the patch make it work for Panda-4430 too.

Thanks Peter for the amixer settings.

Cheers,
Jassi
