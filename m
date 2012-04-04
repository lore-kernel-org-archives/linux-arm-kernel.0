From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 4 Apr 2012 10:39:54 +0000
Subject: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
In-Reply-To: <CAMQu2gxuFsovKTPK8wFOO8vMeiyMFnTqNDRZYgAcCsVWytpOTA@mail.gmail.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>
 <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
 <4F672364.3020403@ti.com>
 <79CD15C6BA57404B839C016229A409A83182386C@DBDE01.ent.ti.com>
 <CAMQu2gyFNXgx87Fsq5is88DOkOx-nWK6ohwyFV-CY2uTkZCGMA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EA54@DBDE01.ent.ti.com>
 <CAMQu2gyF83HJOE9Rf-fZXXMt=p_WFjFf3DpAeW8L8+htR4E6-g@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83183EB47@DBDE01.ent.ti.com>
 <CAMQu2gzYULK+=6-WKQnnQDpzTYW7xKAOZo7obyu2q178jtNE-Q@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A831840C2E@DBDE01.ent.ti.com>
 <CAMQu2gw7aceHSYSd+UMVS6kHQMqy0_maf8QTJaUMzp9z8822rQ@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A831840E0C@DBDE01.ent.ti.com>
 <4F7570FC.8000907@ti.com>
 <79CD15C6BA57404B839C016229A409A831840F82@DBDE01.ent.ti.com>
 <CAMQu2gzOkE6LD0WZ_9bKe3J-=Dv89rWaMzvWWvJHPMSPe6MzNg@mail.gmail.com>
 <CACVXFVPbU2OqTN=S0AZCD10KuSBYxqyyRH_xee+WTaCD6VSmMQ@mail.gmail.com>
 <CAMQu2gzuQ-q+3RHsW0=U305jCF-td5-PEXkGZ6WnQTqA1K8oAQ@mail.gmail.com>
 <CACVXFVPu1GEQy+sCgXMB8JCszPBBs8zHRVm94TYb1-y2afkqgw@mail.gmail.com>
 <CAMQu2gwuRpZ133962r3N4Y4K3oQ88ySa=SyoS6v=sSHGA=SGKw@mail.gmail.com>
 <CACVXFVMjSPhF_+CfbF2vD5ts+WtZGjofEWmknB0D1OpTM7geZw@mail.gmail.com>
 <CAMQu2gyEUhDyyng+_oC5NpXHzWMaTGsnCSTTZcMUi2pLV0z8RQ@mail.gmail.com>
 <87sjgmt211.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A8318461E8@DBDE01.ent.ti.com>
 <CAMQu2gxuFsovKTPK8wFOO8vMeiyMFnTqNDRZYgAcCsVWytpOTA@mail.gmail.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83184715A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 14:34:09, Shilimkar, Santosh wrote:
> On Tue, Apr 3, 2012 at 9:05 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> > On Tue, Apr 03, 2012 at 00:05:38, Hilman, Kevin wrote:
> >> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
> >>
> >> [...]
> >>
> >> > I don't personally like to add features which hardly anybody use and
> >> > fundamentally broken with full kernel.
> >>
> >> Let's keep sane defaults, but not make it unreasonable to tweak eaither.
> >>
> >> I suggest what has already been mentioned.
> >>
> >> Register both timers, but have the sync timer have a higher rating. ?On
> >> AMxxx where there is no sync timer, GPtimer will be used.
> >>
> >
> > This is another good option, I can change the rating of both the timers.
> > With below description and given understanding/discussion/usability of both
> > the timers, we can reverse the rating,
> >
> Btw, if we are going with this path, then there won't any need of commandline
> option since clock-source can be switched from user space as well.
> 

Yes, both the options will be open now and its upto user how he want to 
choose it (either bootargs or sysfs).

Thanks,
Vaibhav
