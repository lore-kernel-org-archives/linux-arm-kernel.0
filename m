From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 7 Oct 2011 23:45:21 +0800
Subject: [PATCH] PM: HIBERNATION: add resume_wait param to support
	MMC-like devices as resume file
In-Reply-To: <20111006175818.GB9886@atrey.karlin.mff.cuni.cz>
References: <1317288548-19560-1-git-send-email-Barry.Song@csr.com>
	<CAKPcRGr3EzjS2es6HniuQziEivpsfH2r=d_Y=nkrsFW59g6xSw@mail.gmail.com>
	<CAGsJ_4zjRpEx_yLwXx74uipPN-Q2hun3AdLxKw2EYOy00cDm3Q@mail.gmail.com>
	<20111006175818.GB9886@atrey.karlin.mff.cuni.cz>
Message-ID: <CAGsJ_4wfpsTMEhs_-N1itXcJB03nvdfyjj+ksWG5g9YRB6Trgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/7 Pavel Machek <pavel@ucw.cz>:
>> 2011/9/29 Luca Tettamanti <kronos.it@gmail.com>:
>> > On Thu, Sep 29, 2011 at 11:29 AM, Barry Song <Barry.Song@csr.com> wrote:
>> >> From: Barry Song <baohua.song@csr.com>
>> >>
>> >> Some devices like mmc are async detected very slow. For example,
>> >> drivers/mmc/host/sdhci.c launchs a 200ms delayed work to detect
>> >> mmc partitions then add disk.
>> >>
>> >> we do have wait_for_device_probe and scsi_complete_async_scans
>> >> before calling swsusp_check, but it is not enough to wait mmc.
>> >>
>> >> This patch adds resumewait kernel param just like rootwait so
>> >> that we have enough time to wait mmc ready. The differene is
>> >> here we wait for resume partition but rootwait waits for rootfs
>> >> partition.
>> >
>> > I assume that such a device would need "rootwait" to boot in the first
>> > place; why don't you "overload" the param to also enable waiting in
>> > the resume path?
>>
>> not real. for an embedded product, the type of the rootfs, the place
>> of the rootfs ?and the way to mount rootfs are pretty flexible.
>> even though both rootfs and resume file use mmc, they will be in
>> different partitions at least. so i don't think rootwait can overload
>> resumewait.
>
> It would be good to at least model it the same way. rootdelay allows
> you to specify time, which is important for USB devices...

actually i considered resumedelay before i sent this resumewait patch.
now resumedelay is not an indispensable feature to my application and
most other systems since they are able to wait for the swap devices
ready by resumewait.
but of course we can have the resumedelay param as well just like
rootdelay. since Rafael has applied this resumedelay patch,  i can
treat resumedelay as one new seperate patch.

>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
-barry
