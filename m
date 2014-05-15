From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Thu, 15 May 2014 21:19:50 +0530
Subject: [PATCH v6 0/5] MCPM backend for Exynos5420
In-Reply-To: <CAM4voam29e7aK7n86_Mpj-wwvkchm-e68qA5=iUFou+sUMONig@mail.gmail.com>
References: <1399982324-27879-1-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1405131325060.980@knanqh.ubzr>
 <CAM4voanvVwj+FuWazTGMHMnM64Cw_qK03D3o=raS43f_zWFfog@mail.gmail.com>
 <alpine.LFD.2.11.1405140031490.980@knanqh.ubzr>
 <CAM4voa=6osyXYg_XF=XuGRYmxLDUO+5=-i+cMrNW92fzBZJjfA@mail.gmail.com>
 <alpine.LFD.2.11.1405140931380.980@knanqh.ubzr>
 <CAM4voam29e7aK7n86_Mpj-wwvkchm-e68qA5=iUFou+sUMONig@mail.gmail.com>
Message-ID: <CAM4voakB57mgyQmtkpCUAF1BVW5z3BGsesvxvTuSg_JwBh-sxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Wed, May 14, 2014 at 7:09 PM, Abhilash Kesavan
<kesavan.abhilash@gmail.com> wrote:
> Hi Nicolas,
>
> On Wed, May 14, 2014 at 7:03 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> On Wed, 14 May 2014, Abhilash Kesavan wrote:
>>
>>> Hi Nicolas,
>>>
>>> [...]
>>> >>
>>> >> 1) can't create /sys/devices/system/cpu/cpu//online: nonexistent directory
>>> >
>>> > What do you get if you do:
>>> >
>>> > $ ls -d /sys/devices/system/cpu/cpu?/online
>>> ls: /sys/devices/system/cpu/cpu//online: No such file or directory
>>
>> Somehow, you or your shell replaced the ? character into a / character.
>> You could try with a * instead.
> With a different RFS your script runs fine without any change. Will
> update with results once testing is done.
The script has been running for a few hours on my 5420 based
chromebook. I can see all the cores being hotplugged in/out. A snippet
of the prints, that I get on running the test, follows:

===========================================
[ 2408.454198] CPU4: Booted secondary processor
[ 2408.461468] CPU6: Booted secondary processor
[ 2408.466306] CPU2: Booted secondary processor
[ 2408.527229] CPU7: shutdown
[ 2408.571822] CPU3: shutdown
[ 2408.611762] CPU1: shutdown
[ 2408.647230] CPU6: shutdown
027316[ 2408.686885] CPU2: shutdown
[ 2408.691756] CPU3: Booted secondary processor
[ 2408.696468] CPU0: Booted secondary processor
2[ 2408.705123] CPU2: Booted secondary processor
[ 2408.747231] CPU4: shutdown
4[ 2408.776798] CPU3: shutdown
[ 2408.786452] CPU4: Booted secondary processor
[ 2408.796497] CPU1: Booted secondary processor
3[ 2408.852188] CPU4: shutdown
[ 2408.856478] CPU7: Booted secondary processor
[ 2408.861457] CPU5: Booted secondary processor
4[ 2408.865536] CPU4: Booted secondary processor
[ 2408.921844] CPU1: shutdown
[ 2408.926486] CPU6: Booted secondary processor
[ 2408.931539] CPU3: Booted secondary processor
1[ 2408.967235] CPU7: shutdown
7[ 2409.011792] CPU3: shutdown
[ 2409.016529] CPU1: Booted secondary processor
3[ 2409.082196] CPU6: shutdown
6[ 2409.126847] CPU0: shutdown
[ 2409.172204] CPU4: shutdown
[ 2409.176441] CPU7: Booted secondary processor
04[ 2409.226786] CPU2: shutdown
[ 2409.229347] CPU4: Booted secondary processor
2[ 2409.272214] CPU7: shutdown
[ 2409.276462] CPU0: Booted secondary processor
7[ 2409.317145] CPU5: shutdown
[ 2409.321589] CPU3: Booted secondary processor
[ 2409.326465] CPU7: Booted secondary processor
[ 2409.331456] CPU2: Booted secondary processor
5[ 2409.335634] CPU5: Booted secondary processor
[ 2409.382202] CPU4: shutdown
4[ 2409.421861] CPU1: shutdown
[ 2409.461784] CPU2: shutdown
[ 2409.466485] CPU6: Booted secondary processor
1[ 2409.471381] CPU1: Booted secondary processor
2[ 2409.522210] CPU5: shutdown
5[ 2409.582098] CPU7: shutdown
[ 2409.586421] CPU2: Booted secondary processor
7[ 2409.642135] CPU6: shutdown
6[ 2409.681787] CPU1: shutdown
1[ 2409.716719] CPU0: shutdown
[ 2409.721476] CPU7: Booted secondary processor
[ 2409.726454] CPU5: Booted secondary processor
0[ 2409.731046] CPU0: Booted secondary processor
[ 2409.736473] CPU1: Booted secondary processor
[ 2409.772226] CPU7: shutdown
7[ 2409.816833] CPU3: shutdown
[ 2409.821472] CPU4: Booted secondary processor
3[ 2409.871810] CPU0: shutdown
[ 2409.912194] CPU4: shutdown
[ 2409.957127] CPU5: shutdown
[ 2409.961456] CPU6: Booted secondary processor
[ 2409.966447] CPU3: Booted secondary processor
[ 2409.970816] CPU5: Booted secondary processor
[ 2410.011828] CPU2: shutdown
[ 2410.041787] CPU1: shutdown
[ 2410.044138] CPU2: Booted secondary processor
0452[ 2410.047629] CPU0: Booted secondary processor
[ 2410.056582] CPU4: Booted secondary processor
[ 2410.060400] CPU1: Booted secondary processor
1[ 2410.116858] CPU2: shutdown
[ 2410.121472] CPU7: Booted secondary processor
2[ 2410.176838] CPU1: shutdown
[ 2410.181614] CPU2: Booted secondary processor
1[ 2410.237224] CPU4: shutdown
4[ 2410.286853] CPU2: shutdown
[ 2410.291472] CPU4: Booted secondary processor
2[ 2410.341767] CPU3: shutdown
[ 2410.346579] CPU1: Booted secondary processor
[ 2410.351585] CPU2: Booted secondary processor
3[ 2410.387251] CPU7: shutdown
7[ 2410.426854] CPU1: shutdown
1[ 2410.477217] CPU5: shutdown
5[ 2410.526810] CPU0: shutdown
[ 2410.529108] CPU7: Booted secondary processor
[ 2410.536432] CPU1: Booted secondary processor
[ 2410.592173] CPU7: shutdown
[ 2410.637141] CPU4: shutdown
[ 2410.641459] CPU7: Booted secondary processor
07[ 2410.646392] CPU0: Booted secondary processor
4[ 2410.652206] CPU4: Booted secondary processor
[ 2410.701872] CPU1: shutdown
1[ 2410.746764] CPU0: shutdown
[ 2410.751481] CPU5: Booted secondary processor
[ 2410.756512] CPU1: Booted secondary processor
[ 2410.761505] CPU3: Booted secondary processor
[ 2410.812331] CPU7: shutdown
[ 2410.851841] CPU3: shutdown
[ 2410.854089] CPU7: Booted secondary processor
[ 2410.902210] CPU6: shutdown
[ 2410.906476] CPU3: Booted secondary processor
[ 2410.961858] CPU2: shutdown
07362[ 2411.011814] CPU3: shutdown
[ 2411.016561] CPU2: Booted secondary processor
3[ 2411.057255] CPU4: shutdown
[ 2411.061626] CPU6: Booted secondary processor
4[ 2411.111898] CPU2: shutdown
[ 2411.116443] CPU4: Booted secondary processor
2[ 2411.166769] CPU1: shutdown
[ 2411.170693] CPU3: Booted secondary processor
[ 2411.222264] CPU7: shutdown
[ 2411.262199] CPU5: shutdown
17[ 2411.266511] CPU1: Booted secondary processor
[ 2411.271614] CPU2: Booted secondary processor
5[ 2411.327240] CPU4: shutdown
[ 2411.331394] CPU0: Booted secondary processor
4[ 2411.381868] CPU1: shutdown
1[ 2411.426780] CPU3: shutdown
[ 2411.431477] CPU5: Booted secondary processor
3[ 2411.441362] CPU3: Booted secondary processor
[ 2411.492221] CPU5: shutdown
[ 2411.501452] CPU1: Booted secondary processor
[ 2411.505211] CPU5: Booted secondary processor
5[ 2411.511488] CPU4: Booted secondary processor
[ 2411.566926] CPU0: shutdown
[ 2411.612216] CPU5: shutdown
0[ 2411.616661] CPU0: Booted secondary processor
[ 2411.621520] CPU7: Booted secondary processor
5[ 2411.628604] CPU5: Booted secondary processor
===========================================

Is there anything else that needs to be checked to ensure that the
script is running as expected ?

Regards,
Abhilash
