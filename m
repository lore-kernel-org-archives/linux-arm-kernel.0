From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Jan 2018 17:34:01 +0100
Subject: [PATCH 1/3] arm: spear600: Add missing interrupt-parent of rtc
In-Reply-To: <CACRpkdag317LU2_3H-PPV_0xoX2RDLxBX5r4a3jpbn9LTvhkcA@mail.gmail.com>
References: <a062d9ed0d3365b578156a780202fa533e725374.1515650104.git.viresh.kumar@linaro.org>
 <20180112020711.6gp2pnsxxjzelidq@localhost> <20180112032223.GK3626@vireshk-i7>
 <CAOesGMggU73asY1SEUDD_BsWcrGYR___o8e5omjziOPEwJgqBQ@mail.gmail.com>
 <CAK8P3a2SO4=YKBE3L_AKsyfNe77YR7a8F=dvbS=ic03=6NK8MA@mail.gmail.com>
 <CAOesGMgcf9FovbzhPkKnrG4ETRFP3dsSJnTYNfp1wECMFeFOGA@mail.gmail.com>
 <CAL_JsqJVWLazDRB1me2OubqqMhdsqsR+cLSHR+K0OY3dZHcE-w@mail.gmail.com>
 <CAOesGMiyfpRyoe4dxQeNMF5invysVBEy+J5OwUhuop=JyAvZoQ@mail.gmail.com>
 <CAK8P3a3KTz0sOSbO9+sAY1Sv95hZF4Yg1qMzOaXPAZ_1pOgGpg@mail.gmail.com>
 <CAOesGMiHeitS_j9r0DsPf3k1jVJT9_z-bHyrhbB7fQ__LjjaqA@mail.gmail.com>
 <CAK8P3a3MZX-ZsxX9h1-8kVQhn9hqY=c8L1+=e3uTfjEjBCYuPg@mail.gmail.com>
 <CACRpkdag317LU2_3H-PPV_0xoX2RDLxBX5r4a3jpbn9LTvhkcA@mail.gmail.com>
Message-ID: <CAK8P3a1x0GQ1ocd8=b8CGFf5maU=kB4QiPYYzyqq_9wXaO2t=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 14, 2018 at 12:20 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Fri, Jan 12, 2018 at 11:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>>      arch/arm/boot/dts/ste-nomadik-nhk15.dtb: Warning
>> (interrupts_property): Missing interrupt-parent for
>> /amba/clcd at 10120000
>>      arch/arm/boot/dts/ste-nomadik-s8815.dtb: Warning
>> (interrupts_property): Missing interrupt-parent for
>> /amba/clcd at 10120000
> (...)
>> I hope Linus Walleij can find out what the right interrupt-parent
>> should be on the
>> nomadik machine, that is otherwise the last remaining warning.
>
> OK I will look into it.

I took another look myself now since this was the last remaining
dtc warning in linux-next. The answer was easy enough to find
in the git history for the board files: all the on-chip devices are
connected to the same VIC instance. I'll send the patch.

       Arnd
