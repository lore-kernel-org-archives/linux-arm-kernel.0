From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Thu, 21 Jun 2018 17:12:24 +0300
Subject: [PATCH] usb: chipidea: Fix ULPI on imx51
In-Reply-To: <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
Message-ID: <0f31d801-528e-54ee-f385-b7aa3eef414f@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> This patches causes a regression on a imx51-babbage running 4.18-rc1:
>>> I get a kernel hang.
>>>
>>> If I revert it on top of 4.18-rc1, then it boots fine and USB host is
>>> functional.
>>>
>>> I understand this patch fixes a kernel hang for you, so which commit
>>> is responsible for the hang you observe?
>>>
> 
> I never assumed it was a regression and that USB worked on RDU1 board
> before, so I never tried to see if this was a regression. I can only
> tell you that it hangs as soon as any PORTSC registers are accessed.

Hang at register access usually means that module that owns the register
is not clocked.
