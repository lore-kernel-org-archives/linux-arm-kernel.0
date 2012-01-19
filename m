From: aneesh@ti.com (Aneesh V)
Date: Thu, 19 Jan 2012 17:48:52 +0530
Subject: [RFC v2 PATCH 1/3] dt: device tree bindings for DDR memories
In-Reply-To: <4EF034C0.9070401@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>	<1324303533-17458-2-git-send-email-aneesh@ti.com>
 <CAOesGMjOybCbu1Bgxe0Te=XANVOqOPcaDOL_6c4=pVCxzu9ZnA@mail.gmail.com>
 <4EF034C0.9070401@ti.com>
Message-ID: <4F180A2C.8060405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tuesday 20 December 2011 12:39 PM, Aneesh V wrote:
> Hi Olof,
>
> On Monday 19 December 2011 10:22 PM, Olof Johansson wrote:
>> Hi,
>>
>> Some comments below, but also a more general question: How much of
>> this generic data makes sense to encode in the device tree? Final
>> hardware configuration usually has to take into consideration board
>> layout/signal delays, etc, and that's not part of this binding.

When I was looking at your comments again for fixing them, I just
realized that I hadn't answered part of this question. In the recent
OMAPs, memory chips are stacked on to the OMAP, hence board layout etc
doesn't figure in the equation. The only board level details that we
need to program the memory controller are the details about the memory
device itself, which is what this binding is targeting.

>
> The JEDEC specifies base values for all timing parameters. But Vendors
> can improve on these timings and provide better values. Using device
> specific timing values therefore provides scope for optimization.
>
> Everything that I have encoded here is needed by our driver to
> re-configure our SDRAM controller during DVFS. In fact, I have not
> listed all AC timing parameters in the spec in this binding, leaving
> the rest for future users to add if they need them.
>


br,
Aneesh
