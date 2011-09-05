From: yad.naveen@gmail.com (naveen yadav)
Date: Mon, 5 Sep 2011 14:08:41 +0530
Subject: Kernel crash (2.6.35.13)
In-Reply-To: <CAJ8eaTxPRbEGbFtME9HEnR=vUtvCOzkDoRA51AudpcPKcGeOvQ@mail.gmail.com>
References: <CAJ8eaTxPRbEGbFtME9HEnR=vUtvCOzkDoRA51AudpcPKcGeOvQ@mail.gmail.com>
Message-ID: <CAJ8eaTxaUfdX7DiXuAA=18u_m+ESA7fwwkw1zCSF9HrsoC-ydQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding linux-arm

On Thu, Sep 1, 2011 at 4:10 PM, naveen yadav <yad.naveen@gmail.com> wrote:
> Dear All,
>
> I am running a simple test program that just do malloc and memset. The
> testprogram is run using below attached script
>
> while true
> do
> ./stress &
> ./stress &
> ./stress &
> ./stress &
> sleep 1
> done
>
>
> we got this issue on embedded Target.
>
> After analysis we found that most of task(stress_application) is in D
> for uninterruptible sleep.
> application ? ? ? ? ? state
>
> stress ? ? ? ? ? ? ? ? ?x
> stress ? ? ? ? ? ? ? ? ?D
> stress ? ? ? ? ? ? ? ? ?x
> stress ? ? ? ? ? ? ? ? ?D
> stress ? ? ? ? ? ? ? ? ?x
> stress ? ? ? ? ? ? ? ? ?D
> stress ? ? ? ? ? ? ? ? ?x
> sleep ? ? ? ? ? ? ? ? ? D
>
> So I observe after 10-15 min Kernel crash with
>
> Kernel panic - not syncing: Out of memory and no killable processes...
>
>
> I am attaching Kernel Crash log + Test application.
>
> Thanks
>
