From: nishanth.p@gmail.com (Nishanth Peethambaran)
Date: Tue, 19 Feb 2013 14:59:46 +0530
Subject: [Linaro-mm-sig] [PATCH 0/2] Device Tree support for CMA
 (Contiguous Memory Allocator)
In-Reply-To: <5122A402.7030807@gmail.com>
References: <1360845928-8107-1-git-send-email-m.szyprowski@samsung.com>
 <20130214213013.GG1906@pengutronix.de> <511D6076.9090503@gmail.com>
 <20130215083304.GK1906@pengutronix.de> <511E6143.609@gmail.com>
 <CAMcxFTQAOjmzy77eB8nj3JDZ-6mwoMpm8yabtQj04tcLw-giLg@mail.gmail.com>
 <5122A402.7030807@gmail.com>
Message-ID: <CAMcxFTRLpStgR6O9ZJFzs=dODKvVZd5xvPVCkesvhrYx7UVaxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 3:28 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 02/16/2013 11:18 PM, Nishanth Peethambaran wrote:
>> Limiting the scope of the product to a particular use-case (720p or
>> 1080p video playback) will be part of firmware mostly OTP-ed in the
>> SoC. Firmware author could decide the amount of CMA memory needed and
>> put this as part of DT.
>
> What kernel developer would want a firmware author deciding how much
> memory is needed? It is not a decision that can be made without
> knowledge of the OS. While the frame size could be determined easily
> enough based on resolution, the number of buffers needed cannot.
>
> Rob
>

Got your point. Agree that firmware cannot decide on number of buffers.
Hard coding cma areas, and their relation to devices and CMA areas
inside kernel would bring back the concept of board files as drivers should
not have these details. Bootargs support defing cma size but not the relation
to devices.
Having a separate system configuration DT file would bring this configuration
out of firmware. OF format can be reused. System architect should
own the system configuration DT and not kernel developer.

- Nishanth Peethambaran
