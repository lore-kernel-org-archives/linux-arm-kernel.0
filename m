From: trblinux@gmail.com (Tushar Behera)
Date: Thu, 26 Jun 2014 08:50:50 +0530
Subject: [PATCH 2/3] ARM: dts: Update the parent for Audss clocks in
 Exynos5420
In-Reply-To: <7hpphwlgn0.fsf@paris.lan>
References: <1402464739-19044-1-git-send-email-tushar.b@samsung.com>
 <1402464739-19044-3-git-send-email-tushar.b@samsung.com>
 <CAD=FV=W5yh58fYTwRZxmZt=BORcZMSRV0oRe12yA74Q5h2S4YQ@mail.gmail.com>
 <7hpphwlgn0.fsf@paris.lan>
Message-ID: <CAC5m3Bzey-YoPLmjAq4YNPQ13rojtVFWAbnhX6-ZFtYZwEdMWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 4:51 AM, Kevin Hilman <khilman@linaro.org> wrote:
> Doug Anderson <dianders@google.com> writes:
>
>> Tushar,
>>
>> On Tue, Jun 10, 2014 at 10:32 PM, Tushar Behera <tushar.b@samsung.com> wrote:
>>> Currently CLK_FOUT_EPLL was set as one of the parents of AUDSS mux.
>>> As per the user manual, it should be CLK_MAU_EPLL.
>>>
>>> The problem surfaced when the bootloader in Peach-pit board set
>>> the EPLL clock as the parent of AUDSS mux. While booting the kernel,
>>> we used to get a system hang during late boot if CLK_MAU_EPLL was
>>> disabled.
>>>
>>> Signed-off-by: Tushar Behera <tushar.b@samsung.com>
>>> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
>>> Reported-by: Kevin Hilman <khilman@linaro.org>
>>> ---
>>>  arch/arm/boot/dts/exynos5420.dtsi |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> I've tested this myself now as well.
>>
>> Tested-by: Doug Anderson <dianders@chromium.org>
>
> For me, this patch alone (on top of -next) doesn't solve the boot hang.
> I still need clk_ignore_unused for a successful boot.
>
> So, this patch might be correct, but it doesn't prevent a boot hang
> using a chain-loaded nv_uboot on peach-pi.  There's still another clock
> being disabled that causes a hang.
>
> Kevin

Kevin,

Can you please check if adding patch 1/3 alongwith patch 2/3 fixes the
issue for you?

Also can you please confirm that setting CLK_IGNORE_UNUSED flag
CLK_MAU_EPLL alone fixes the issue, without any need for
clk_ignore_unused in u-boot bootargs?

-- 
Tushar Behera
