From: sourav.poddar@ti.com (Poddar, Sourav)
Date: Tue, 21 Aug 2012 17:01:47 +0530
Subject: [PATCH 2/4] Input: keypad: Add smsc ece1099 keypad driver
In-Reply-To: <20120821104647.GU10347@arwen.pp.htv.fi>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-3-git-send-email-sourav.poddar@ti.com>
 <20120821104647.GU10347@arwen.pp.htv.fi>
Message-ID: <CAKdam57p_K-ui1x+u-n07PQ8aweZocDsXoFTtdk_6CAVsC+xOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 21, 2012 at 4:16 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Tue, Aug 21, 2012 at 04:15:38PM +0530, Sourav Poddar wrote:
>> +static struct platform_driver smsc_driver = {
>> +     .driver = {
>> +             .name   = "smsc-keypad",
>> +             .of_match_table = of_match_ptr(smsc_keypad_dt_match),
>> +             .owner  = THIS_MODULE,
>> +     },
>> +     .probe          = smsc_probe,
>> +     .remove         = smsc_remove,
>
> one extra comment which I forgot. You probably should put your remove on
> __devexit and add __devexit_p(smsc_remove) here.
>
yes, Will do it.
> --
> balbi
