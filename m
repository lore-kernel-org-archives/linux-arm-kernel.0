From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 18 Sep 2014 08:48:49 +0200
Subject: [PATCH 2/2] ARM: dts: Add rtc_src clk for s3c-rtc on
 exynos5250-snow
In-Reply-To: <CAD=FV=W7xJ01m2oLtuDnogOmrpwpztbir=59oSWU6oojFYUWKw@mail.gmail.com>
References: <1410954633-27025-1-git-send-email-javier.martinez@collabora.co.uk>	<1410954633-27025-3-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=W7xJ01m2oLtuDnogOmrpwpztbir=59oSWU6oojFYUWKw@mail.gmail.com>
Message-ID: <541A8051.20207@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug, Andreas,

On 09/17/2014 05:47 PM, Doug Anderson wrote:
>>
>>         rtc at 101E0000 {
>>                 status = "okay";
>> +               clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
>> +               clock-names = "rtc", "rtc_src";
> 
> Wait, seriously?  Snow is still using the "rtc at 101E0000" syntax?
> Whatever happened to the series that Andreas worked so hard on,
> including <https://patchwork.kernel.org/patch/4664801/>?
>

Andreas, I completely forgot about your series when writing this patch even
though I've on my TO-DO to sync the downstream and upstream Snow DTS once your
patches land. Sorry about that.

> 
> In any case, there's nothing wrong with Javier's patch other than the
> fact that it will eventually need to get merged with Andreas's, so:
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> 

Thanks, I'll re-spin and post again once Kukjin merges Andreas series.

Best regards,
Javier
