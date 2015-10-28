From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Wed, 28 Oct 2015 09:41:20 +0100
Subject: typo in recent linux commit?
In-Reply-To: <CAPKXbB6Y9esdQm-VevEfhTggA30vmFY424mwiTK9wZR=wORRHg@mail.gmail.com>
References: <CAPKXbB6Y9esdQm-VevEfhTggA30vmFY424mwiTK9wZR=wORRHg@mail.gmail.com>
Message-ID: <30294E2E-4011-4B50-BD26-787977A3F3BB@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 28.10.2015 um 09:19 schrieb Efraim Yawitz <efraim.yawitz@gmail.com>:

> Hi,
> 
> I was just browsing recent commits to the linux kernel tree, and I saw this in a change to arch/arm/vdso/vdsomunge.c:
> 
> +#define swab32(x) \
>    + ((((x) & 0x000000ff) << 24) | \
>    + (((x) & 0x0000ff00) << 8) | \
>    + (((x) & 0x00ff0000) >> 8) | \
>    + (((x) & 0xff000000) << 24))
> 
> 
> Shouldn't that last '<<' be a '>>'?
> 
> Ephraim Yawitz

Yes, you are right! Thanks for spotting this.
It appears that it was introduced during code simplification.

@maintainers: should I write another patch or can you more easily replace the original one?

BR,
Nikolaus Schaller
