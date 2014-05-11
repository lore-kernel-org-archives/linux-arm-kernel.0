From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Sun, 11 May 2014 20:15:50 +0530
Subject: [PATCH v2 0/6] usb: host: Cleanup for ioremap'ing hcd memory
In-Reply-To: <1399731956.962771892@f256.i.mail.ru>
References: <1399723210-21569-1-git-send-email-gautam.vivek@samsung.com>
 <1399731956.962771892@f256.i.mail.ru>
Message-ID: <CAFp+6iFoc5bx5EEJMXZT1021JyN_fx9AouNCuETS127rFkbb2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Sat, May 10, 2014 at 7:55 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> Sat, 10 May 2014 17:30:04 +0530 ?? Vivek Gautam <gautam.vivek@samsung.com>:
>> Based on 'usb-next' branch of Greg's usb tree.
>>
>> devm_ioremap_resource() API is advantageous over devm_ioremap()
>> and should therefore be preferred to request any ioremap'ed address
>> for hcd.
>>
>> Changes from v1:
>>  - Changed the way returned pointer is checked for error value
>>    as pointed out in the review comment in the mailing list.
>
> hcd->rsrc_len field can be removed entirely, since I cannot find any reason
> how this filed can be used in the drivers now.
> This is of course should be in an another series. This one looks good.

True, even i noticed the same, since after grep'ing for rsrc_len. i
could not find any mention in the
USB layer.
Will send that as a separate patch-series.



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
