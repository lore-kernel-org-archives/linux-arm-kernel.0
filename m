From: r.sh.open@gmail.com (Rahul Sharma)
Date: Thu, 29 Aug 2013 08:52:42 +0530
Subject: [PATCH v3 4/5] clk/exynos5420: add hdmi mux to change parents in
 hdmi driver
In-Reply-To: <3222483.BXBstlS3j6@amdc1227>
References: <1377508383-15185-1-git-send-email-rahul.sharma@samsung.com>
 <1919681.jqCQjHmyQW@flatron>
 <CAPdUM4MUvzyAjyFwuYyBY6C-nn_VHttwf=ebAZLgc4VTNgS05A@mail.gmail.com>
 <3222483.BXBstlS3j6@amdc1227>
Message-ID: <CAPdUM4MLz8FapYSr35O_1rZmAw-XvgM6w+7OUKdufJk8hQQPVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Tomasz,

I will post the reworked patches with above change.

regards,
Rahul Sharma


On 28 August 2013 17:25, Tomasz Figa <t.figa@samsung.com> wrote:
> On Tuesday 27 of August 2013 10:14:01 Rahul Sharma wrote:
>> On 27 August 2013 05:16, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> > Hi Rahul,
>> >
>> > On Monday 26 of August 2013 14:43:02 Rahul Sharma wrote:
>> >> hdmi driver needs to change the parent of hdmi clock
>> >> to pixel clock or hdmiphy clock, based on the stability
>> >> of hdmiphy. This patch is exposing the mux for changing
>> >> the parent.
>> >>
>> >> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
>> >> ---
>> >>
>> >>  Documentation/devicetree/bindings/clock/exynos5420-clock.txt |    5
>> >>
>> >> +++++ drivers/clk/samsung/clk-exynos5420.c                         |
>> >> 5 ++++- 2 files changed, 9 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git
>> >> a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
>> >> b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt index
>> >> 5758a69..6f16aa8 100644
>> >> --- a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
>> >> +++ b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
>> >> @@ -182,6 +182,11 @@ clock which they consume.
>> >>
>> >>    g3d                        501
>> >>    smmu_mixer         502
>> >>
>> >> +  Mux                        ID
>> >> +  ----------------------------
>> >> +
>> >> +  mout_hdmi          1024
>> >
>> > Is there a need for such big hole between smm_mixer and this clock? I
>> > believe that based on the documentation, the total amount of clocks
>> > that
>> > can be defined may be approximated and some extra margin added, so you
>> > don't waste so much of numbering space and memory used for lookup
>> > array.
>>
>> Total number of Gates are coming upto the enum value 540. I can leave gap
>> of 64 in between for first mux. Similarly, total muxes in system are
>> 118. Optimum gab would be between 128~150. What you say about these
>> values?
>
> OK, so let's say that muxes should start at 640 and dividers at 768.
>
> Anyway, ideally, we should break from this idea of grouping and convert
> this way of definition to normal preprocessor macros that could be used
> inside dts files as well. Then we could detach ourselves from referring to
> clocks by numbers, because those macros would do that for us, without the
> need to group clocks together for better readability. See clock driver for
> S3C64xx [1].
>
> This is an idea for further work, though. For now the values I proposed
> should be more than enough.
>
> [1] http://thread.gmane.org/gmane.linux.usb.general/90493/focus=21090
>
> Best regards,
> Tomasz
>
