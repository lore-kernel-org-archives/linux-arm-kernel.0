From: robert.richter@cavium.com (Robert Richter)
Date: Thu, 12 Jan 2017 19:58:25 +0100
Subject: [PATCH v3] arm64: mm: Fix NOMAP page initialization
In-Reply-To: <20170112160535.GF13843@arm.com>
References: <20161216165437.21612-1-rrichter@cavium.com>
 <CAKv+Gu_SmTNguC=tSCwYOL2kx-DogLvSYRZc56eGP=JhdrUOsA@mail.gmail.com>
 <c74d6ec6-16ba-dccc-3b0d-a8bedcb46dc5@linaro.org>
 <cbbf14fd-a1cc-2463-ba67-acd6d61e9db1@linaro.org>
 <CAKv+Gu8-+0LUTN0+8OGWRhd22Ls5cMQqTJcjKQK_0N=Uc-0jog@mail.gmail.com>
 <20170109115320.GI4930@rric.localdomain>
 <20170112160535.GF13843@arm.com>
Message-ID: <20170112185825.GE5020@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.01.17 16:05:36, Will Deacon wrote:
> On Mon, Jan 09, 2017 at 12:53:20PM +0100, Robert Richter wrote:

> > Kernel compile times (3 runs each):
> > 
> > pfn_valid_within():
> > 
> > real    6m4.088s
> > user    372m57.607s
> > sys     16m55.158s
> > 
> > real    6m1.532s
> > user    372m48.453s
> > sys     16m50.370s
> > 
> > real    6m4.061s
> > user    373m18.753s
> > sys     16m57.027s
> 
> Did you reboot the machine between each build here, or only when changing
> kernel? If the latter, do you see variations in kernel build time by simply
> rebooting the same Image?

I built it in a loop on the shell, so no reboots between builds. Note
that I was building the kernel in /dev/shm to not access harddisks. I
think build times should be comparable then since there is no fs
caching.

-Robert
