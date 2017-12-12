From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 12 Dec 2017 19:58:12 +0100
Subject: mainline/master boot bisection: v4.15-rc3 on peach-pi
 #3228-staging
In-Reply-To: <fcab4daa-678c-ee48-a5ec-9d22c535ff29@osg.samsung.com>
References: <680389204.71.1512980755810.JavaMail.jenkins@ip-172-30-0-246>
 <51e6d7fb-ac9e-a59f-ea63-ad06219b429d@collabora.com>
 <CAKMK7uFcGftSeQjkKu9SZmkQd8-irbUTMcOnUwi7HZtb5TePag@mail.gmail.com>
 <CABxcv=mUHgTxvYpOYstE7rQn8fKS3QGiTT=FzBUc8DREvVuTeQ@mail.gmail.com>
 <CABxcv=m-fYZvYN4gLwBf8NwHvJb7PtNdVKR+SXgVKExZGtW4Qw@mail.gmail.com>
 <20171211225829.GA1959@n2100.armlinux.org.uk>
 <20171211230213.GB1959@n2100.armlinux.org.uk>
 <CGME20171211232533epcas1p1821f8808ca6da7bd28c57fb4121d36fa@epcas1p1.samsung.com>
 <2df0fc74-8b79-5cca-7a8a-9e005b44d8d8@osg.samsung.com>
 <2139f436-5646-7f9f-a6cb-285a0fd31969@samsung.com>
 <CABxcv=n9PvoYr1xwB8CHBmE00XaTUqT642g7F8nuZd-d031h5Q@mail.gmail.com>
 <88bebc9d-a889-403b-a742-c11ad6617638@samsung.com>
 <beef1026-3dbe-5284-d2fa-a2298c52e7c0@osg.samsung.com>
 <fcab4daa-678c-ee48-a5ec-9d22c535ff29@osg.samsung.com>
Message-ID: <CABxcv=mEB_s9hy2P2qYww1rOGpFLFqAyxOVK0tXDPBJ6eVPbfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shuah,

On Tue, Dec 12, 2017 at 7:26 PM, Shuah Khan <shuahkh@osg.samsung.com> wrote:

[snip]

>>>
>>> Not directly. I still didn't find time to properly add support for
>>> devices, which were left in-working state (with active DMA
>>> transactions) by bootloader, but due to some other changes in the
>>> order of operations during boot process, power domains are
>>> initialized very early and due to temporary lack of devices (which
>>> are not yet added to the system), are turned off. This practically
>>> stops FIMD for scanning framebuffer and "solves" this issue.
>>>
>>> I've checked now and Exynos Snow Chromebook boots fine with IOMMU
>>> support enabled, both with v4.15-rc3 and linux-next.
>
> Would it make sense to enable EXYNOS_IOMMU in exynos_defconfig. I sent
> a patch to do that a while back. The decision at the time to not pull
> that patch is was based on systems not booting with it enabled.
>
> Is it time to revisit that or the recommendation is for IOMMU to be
> enabled in configs manually on systems it is safe to do so?
>

Yes, I think it would be good to have it enabled by default if that
doesn't cause boot issues anymore.

Could you please resend your patch and cc Marek and me so we can test
on Snow and Peach Chromebooks?

> thanks,
> -- Shuah

Best regards,
Javier
