From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 28 Mar 2013 14:27:13 +0800
Subject: [PATCH] pinctrl:sirf:re-arch and add support for new SiRFatlas6
 SoC
In-Reply-To: <CACRpkdYUTQ_7V1CbKbx05zgBONj6iUi=ekzSwmZz8dqeRx7ZJw@mail.gmail.com>
References: <1363597988-7409-1-git-send-email-Barry.Song@csr.com>
 <CACRpkdYUTQ_7V1CbKbx05zgBONj6iUi=ekzSwmZz8dqeRx7ZJw@mail.gmail.com>
Message-ID: <CAGsJ_4wmn-LxxX-JeSJzdkVFSUeJ=vQrKHJr9yUtsoxG2BFHtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/28, Linus Walleij <linus.walleij@linaro.org>:
> On Mon, Mar 18, 2013 at 10:13 AM, Barry Song <Barry.Song@csr.com> wrote:
>
>> atlas6 is a SoC very similar with primaII, the register layput of
>> pinctrl is same, but the pads, groups and functions of atlas6 have
>> different layout with prima2, this patch
>> 1. pull the definition of pads, groups and functions out of the
>> pinctrl-sirf driver,and put them into soc-specific files
>> 2. add pads, groups and functions tables for atlas6
>> 3. let pads, groups and functions tables become the config data of
>>    the related dt compatible node, so the pinctrl-sirf can support
>>    all SiRF SoCs with the config data as private data.
>>
>> In this patch,we create a sirf dir, and let
>> the old drivers/pinctrl/pinctrl-sirf.c =
>>         drivers/pinctrl/sirf/pinctrl-prima2.c +
>>         drivers/pinctrl/sirf/pinctrl-sirf.c
>>
>> drivers/pinctrl/sirf/pinctrl-atlas6.c is a newly created file for the
>> pin layout of atlas6.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> This is OK but can you please:

ok. one issue is recently Arnd has given another changes in
pinctrl-sirf in arm-soc multiple platform branch:
https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?h=prima2/multiplatform&id=67d71344fd09223820eb9de39b597ec29f035e89

it makes us easily to get merging conflict. what is your suggestion
about taking all these changes in 3.10?

>
> - Base the patch on the "devel" branch in my pinctrl tree?
>
> - Try to use the -M flag when formatting the patch so it
>   gets more readable?

yes. i did have already done that in this patch as you see:
"
 rename drivers/pinctrl/{pinctrl-sirf.c => sirf/pinctrl-prima2.c} (50%)
"
but git -M has failed to know this:
drivers/pinctrl/{pinctrl-sirf.c => sirf/pinctrl-sirf}

it seems git -M can't support the case a file are forked to 2 files
and let the 2 files follow the old file. it only lets one follow the
old file.

>
> Yours,
> Linus Walleij

-barry
