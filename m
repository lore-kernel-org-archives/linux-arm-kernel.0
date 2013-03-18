From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 18 Mar 2013 15:17:54 +0530
Subject: [PATCH v6 1/2] ARM: davinci: dm365: add support for v4l2 video
 display
In-Reply-To: <CA+V-a8umwxKFHjSQ=yDwfp8VWTQyn0dyp-=ESSUvRPXawt01Jg@mail.gmail.com>
References: <1363360303-15521-1-git-send-email-prabhakar.csengg@gmail.com>
 <1363360303-15521-2-git-send-email-prabhakar.csengg@gmail.com>
 <5146CDC5.9000702@ti.com>
 <CA+V-a8umwxKFHjSQ=yDwfp8VWTQyn0dyp-=ESSUvRPXawt01Jg@mail.gmail.com>
Message-ID: <5146E2CA.8000109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/18/2013 2:46 PM, Prabhakar Lad wrote:
> On Mon, Mar 18, 2013 at 1:48 PM, Sekhar Nori <nsekhar@ti.com> wrote:
>> On 3/15/2013 8:41 PM, Prabhakar lad wrote:

>>> +int __init dm365_init_video(struct vpfe_config *vpfe_cfg,
>>> +                             struct vpbe_config *vpbe_cfg)
>>> +{
>>> +     if (vpfe_cfg || vpbe_cfg)
>>> +             platform_device_register(&dm365_vpss_device);
>>> +
>>> +     if (vpfe_cfg) {
>>> +             vpfe_capture_dev.dev.platform_data = vpfe_cfg;
>>> +             /* Add isif clock alias */
>>
>> This comment is useless. Instead please document why the aliases are
>> needed. I know you are just moving code here, but lets do a clean-up job
>> while at it.
>>
> by document you mean to add a file in Documentation folder ?

No, just modify the comment to talk about why the aliases are needed.

Thanks,
Sekhar
