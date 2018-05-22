From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Tue, 22 May 2018 11:42:55 +0800
Subject: [PATCH 12/33] clk: bcm2835: use match_string() helper
In-Reply-To: <CAHp75Vf6rDpFQCt+qG3DSWKZm36F1hkAVPtGzr6NHPuQg4vhXQ@mail.gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-13-git-send-email-xieyisheng1@huawei.com>
 <CAHp75Vf6rDpFQCt+qG3DSWKZm36F1hkAVPtGzr6NHPuQg4vhXQ@mail.gmail.com>
Message-ID: <00acb90b-1c2c-a855-2a8f-f60a859a0f85@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On 2018/5/22 5:50, Andy Shevchenko wrote:
> On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> match_string() returns the index of an array for a matching string,
>> which can be used intead of open coded variant.
>>
>> Cc: Michael Turquette <mturquette@baylibre.com>
>> Cc: Stephen Boyd <sboyd@kernel.org>
>> Cc: Eric Anholt <eric@anholt.net>
>> Cc: Stefan Wahren <stefan.wahren@i2se.com>
>> Cc: linux-clk at vger.kernel.org
>> Cc: linux-rpi-kernel at lists.infradead.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> 
>> -       size_t i, j;
>> -       int ret;
>> +       int i, ret;
> 
> I do not see any need to change type for i.

Right, I just want to smaller the line of code, for unsinged int is also OK for i.
Anyway, I can change it as your suggestion in next version.

Thanks
Yisheng

> 
>> +               ret = match_string(cprman_parent_names,
>> +                                  ARRAY_SIZE(cprman_parent_names),
>> +                                  parents[i]);
>> +               if (ret >= 0)
>> +                       parents[i] = cprman->real_parent_names[ret];
> 
> 
