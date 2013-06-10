From: airlied@gmail.com (Dave Airlie)
Date: Tue, 11 Jun 2013 09:48:57 +1000
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130610233611.GK18614@n2100.arm.linux.org.uk>
References: <CAF6AEGs+=56nntyJfy6cMHsehmhzFGcfGUC53RgNW=HfFW=qRA@mail.gmail.com>
 <20130610170648.GX18614@n2100.arm.linux.org.uk>
 <CAF6AEGuGuCtYQo_W3RVJ_69iDxq17s3y_y7eNmWRCw41YUvZmg@mail.gmail.com>
 <20130610200839.GY18614@n2100.arm.linux.org.uk>
 <CAF6AEGsfzvdiGXqAu56rc-G_ZhhE_vnNbC6kpBmRtd-8Sh_uOQ@mail.gmail.com>
 <20130610211516.GZ18614@n2100.arm.linux.org.uk>
 <CAF6AEGu-e+cZW-1F6L+epE11oonFucreEY_KH+awRx7j5pScpA@mail.gmail.com>
 <20130610225607.GE18614@n2100.arm.linux.org.uk>
 <CAF6AEGvAqF=SbxW=D_ymbW+w9SEqfouxPsVZEsctdk-iM79L5w@mail.gmail.com>
 <CAPM=9twJGgYiXxQyaXCnYd+bUPFv+P92qGdmJ39_4z29==4F2g@mail.gmail.com>
 <20130610233611.GK18614@n2100.arm.linux.org.uk>
Message-ID: <CAPM=9tz6p2rhjNUg7ednT09A+dztbYskF32QkZeaCi_qrH8ipw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 9:36 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 11, 2013 at 09:24:16AM +1000, Dave Airlie wrote:
>> I'd like to see all the ARM based drivers based on CMA if it can meet
>> their requirements
>> and using close to standard GEM/dma-buf interfaces. Otherwise it'll be
>> come an unmaintainable
>> nightmare for everyone, but mostly for me.
>
> I am *not* using the CMA layer - that layer is just plain broken in
> DRM.  It forces every single gem object to be a CMA allocated object,
> which means I can't have cacheable pixmaps in X.  And that makes X
> suck.
>
> Okay, I'm pulling this and I'm going to keep it in my private cubox
> tree; I'm not persuing pushing this driver or any other Armada 510
> driver into mainline anymore.  It's just too much fscking hastle
> dealing with people who don't like various stuff.
>
> I've done my best to clean a lot of the crap up, and the problem is
> that no matter how much I clean up, it remains unacceptable.  Only
> the 100% perfect solution seems to be acceptable.  That is
> unacceptable given that this stuff has already consumed something
> like 8 months solid of my time.

Russell, aren't you a kernel maintainer, because for fuck sake get real.

I'm not merging bullshit into my tree that has a completely broken API that
has to be maintained for ever. You of all people should understand we
don't break Linux
userspace APIs, and adding a phys addr one is wrong, wrong, wrong, its not
cleanups, its just broken, and I'll never merge it.

Dave.
