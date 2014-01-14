From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Tue, 14 Jan 2014 13:14:28 +0200
Subject: [PATCH] ARM: OMAP4: sleep: byteswap data for big-endian
In-Reply-To: <52D404DE.2020806@ti.com>
References: <1389625399-24087-1-git-send-email-taras.kondratiuk@linaro.org>
 <52D404DE.2020806@ti.com>
Message-ID: <CAArO44samX_uMeC93w4DBbC+yskEmrvVt_i-5VV_seatM56ypw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 January 2014 17:23, Nishanth Menon <nm@ti.com> wrote:
> On 01/13/2014 09:03 AM, Taras Kondratiuk wrote:
>> From: Victor Kamensky <victor.kamensky@linaro.org>
>>
>> Assembler functions defined in sleep44xx.S need to byteswap values
>> after read / before write from h/w register if code compiled in big
>> endian mode. Simple change to do 'rev x, x' before str instruction
>> and after ldr instruction that deals with h/w registers.
>>
>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
>> ---
>> This is a part of RFC series [1].
>> Based on v3.13-rc8.
>>
>> [1] http://www.spinics.net/lists/linux-omap/msg99927.html
>>
>>  arch/arm/mach-omap2/sleep44xx.S |   17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>
> OMAP4 is LE, and if there is a gcc flag for the same, is'nt it cleaner
> to deal with it in Makefile rather than trying to make an assembly
> meant only for LE by force building it for BE?

Hi Nishanth
I'm not sure I got your point.
Do you propose to build this file as LE while the rest of kernel is BE?

-- 
Regards,
Taras Kondratiuk
