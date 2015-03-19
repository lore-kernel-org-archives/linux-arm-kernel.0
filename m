From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 19 Mar 2015 15:11:27 +0800
Subject: [PATCH 2/2] ARM: dts: sunxi: Remove overclocked/overvoltaged OPP
In-Reply-To: <20150319085925.70d8a10d@i7>
References: <1426732773-7179-1-git-send-email-wens@csie.org>
 <1426732773-7179-3-git-send-email-wens@csie.org> <20150319085925.70d8a10d@i7>
Message-ID: <CAGb2v678kt6vL7j0sbJn-ftNkQuXTDiJMChhdX7k=NvRUE22Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 2:59 PM, Siarhei Siamashka
<siarhei.siamashka@gmail.com> wrote:
> On Thu, 19 Mar 2015 10:39:33 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
>
>> Without proper regulator support for individual boards, it is dangerous
>> to have overclocked/overvoltaged OPPs in the list. Cpufreq will increase
>> the frequency without the accompanying voltage increase, resulting in
>> an unstable system.
>>
>> Remove them for now. We can revisit them with the new version of OPP
>> bindings, which support boost settings and frequency ranges, among
>> other things.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sun5i-a13.dtsi | 3 +--
>>  arch/arm/boot/dts/sun7i-a20.dtsi | 3 +--
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> What about the sun4i-a10.dtsi file? Was it forgotten or skipped
> deliberately?

sun4i-a10.dtsi does not have any overclocked/overvoltaged settings.
The highest setting is 1008MHz @ 1.4V.

ChenYu
