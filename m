From: robdclark@gmail.com (Rob Clark)
Date: Mon, 10 Jun 2013 19:35:23 -0400
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <CAPM=9twJGgYiXxQyaXCnYd+bUPFv+P92qGdmJ39_4z29==4F2g@mail.gmail.com>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk>
 <CAF6AEGs+=56nntyJfy6cMHsehmhzFGcfGUC53RgNW=HfFW=qRA@mail.gmail.com>
 <20130610170648.GX18614@n2100.arm.linux.org.uk>
 <CAF6AEGuGuCtYQo_W3RVJ_69iDxq17s3y_y7eNmWRCw41YUvZmg@mail.gmail.com>
 <20130610200839.GY18614@n2100.arm.linux.org.uk>
 <CAF6AEGsfzvdiGXqAu56rc-G_ZhhE_vnNbC6kpBmRtd-8Sh_uOQ@mail.gmail.com>
 <20130610211516.GZ18614@n2100.arm.linux.org.uk>
 <CAF6AEGu-e+cZW-1F6L+epE11oonFucreEY_KH+awRx7j5pScpA@mail.gmail.com>
 <20130610225607.GE18614@n2100.arm.linux.org.uk>
 <CAF6AEGvAqF=SbxW=D_ymbW+w9SEqfouxPsVZEsctdk-iM79L5w@mail.gmail.com>
 <CAPM=9twJGgYiXxQyaXCnYd+bUPFv+P92qGdmJ39_4z29==4F2g@mail.gmail.com>
Message-ID: <CAF6AEGsO-j-r0xCxZfbr7OrG=hpA5W0icA40NDfZi7oD75iF3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 7:24 PM, Dave Airlie <airlied@gmail.com> wrote:
>>>
>>> That makes the driver just be a dumb scanout only driver.  Sorry,
>>> that *really* does not interest me one bit, because the CPU doing
>>> framebuffer accesses is pig slow.
>>
>> Well, yes that is basically what I am saying, unless we can find a
>> different way (dmabuf? if there is some way to pass it through the
>> blob bits you don't have src code for?)
>>
>> The problem is that we really can't merge something upstream that lets
>> you dma to arbitrary physical address.  Maybe in staging, perhaps?  Or
>> otherwise if there is no other way, I hope someone will at least pick
>> up the modesetting parts of it and get that merged upstream.  The rest
>> of the driver is looking pretty good, and I think it would be useful
>> to have upstream.
>
> Totally what he said.
>
> upstream shouldn't be restricted by the bad decisions of others, and
> adding security bypasses is one of them.
>
> I'd like to see all the ARM based drivers based on CMA if it can meet
> their requirements

afaiu CMA has issues w/ changing cache attributes of pages on older
architectures like Russell is using.  Although perhaps on older arm
CMA should just be a straight carveout pool and not try to recycle the
unused pages.  At least then it would be the same API for the drivers.

BR,
-R

> and using close to standard GEM/dma-buf interfaces. Otherwise it'll be
> come an unmaintainable
> nightmare for everyone, but mostly for me.
>
> Merging the base dumb KMS driver, then working out acceptable ways to
> provide the extra
> features is definitely the nicest way to do things.
>
> Dave.
