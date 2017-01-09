From: robert.richter@cavium.com (Robert Richter)
Date: Mon, 9 Jan 2017 12:53:20 +0100
Subject: [PATCH v3] arm64: mm: Fix NOMAP page initialization
In-Reply-To: <CAKv+Gu8-+0LUTN0+8OGWRhd22Ls5cMQqTJcjKQK_0N=Uc-0jog@mail.gmail.com>
References: <20161216165437.21612-1-rrichter@cavium.com>
 <CAKv+Gu_SmTNguC=tSCwYOL2kx-DogLvSYRZc56eGP=JhdrUOsA@mail.gmail.com>
 <c74d6ec6-16ba-dccc-3b0d-a8bedcb46dc5@linaro.org>
 <cbbf14fd-a1cc-2463-ba67-acd6d61e9db1@linaro.org>
 <CAKv+Gu8-+0LUTN0+8OGWRhd22Ls5cMQqTJcjKQK_0N=Uc-0jog@mail.gmail.com>
Message-ID: <20170109115320.GI4930@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.01.17 08:37:25, Ard Biesheuvel wrote:
> Any comments on the performance impact (including boot time) ?

I did a kernel compile test and kernel mode time increases by about
2.2%. Though this is already significant, we need a more suitable mem
benchmark here for further testing.

For boot time I dont see significant changes.

-Robert


Boot times:

pfn_valid_within():
[   25.929134]
[   25.548830]
[   25.503225]

early_pfn_valid() v3:
[   25.773814]
[   25.548428]
[   25.765290]


Kernel compile times (3 runs each):

pfn_valid_within():

real    6m4.088s
user    372m57.607s
sys     16m55.158s

real    6m1.532s
user    372m48.453s
sys     16m50.370s

real    6m4.061s
user    373m18.753s
sys     16m57.027s


early_pfn_valid() v3:

real    6m3.261s
user    373m15.816s
sys     16m30.019s

real    6m2.980s
user    373m9.019s
sys     16m32.992s

real    6m2.574s
user    372m45.146s
sys     16m33.218s
