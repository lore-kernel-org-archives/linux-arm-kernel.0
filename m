From: tyler.baker@linaro.org (Tyler Baker)
Date: Thu, 13 Apr 2017 12:24:27 -0700
Subject: [PATCH 4/8] ARM: dts: imx7s: Add node for GPC
In-Reply-To: <CAOMZO5CgLP7P+Q2Mvzpnx6u5ryb1TjAvaj9xDKXpD+8fMmn7MQ@mail.gmail.com>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-5-andrew.smirnov@gmail.com>
 <CANMBJr5sFeVxVq2w2uUd-ehXi9SpaJ7W9S_PTS_VN25YZEdXvQ@mail.gmail.com>
 <CAOMZO5CgLP7P+Q2Mvzpnx6u5ryb1TjAvaj9xDKXpD+8fMmn7MQ@mail.gmail.com>
Message-ID: <CANMBJr4BWtU7SXEa0-4LFLx+ydVWas0Cx18kRn-=-Bz8pPZ=fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 April 2017 at 12:18, Fabio Estevam <festevam@gmail.com> wrote:
> On Thu, Apr 13, 2017 at 4:03 PM, Tyler Baker <tyler.baker@linaro.org> wrote:
>
>> I've been testing your GPC/PCIe patch sets against v4.11-rc5 on my
>> imx7d-cl-som-imx7, but hit a bit of a wall. When gpc is set as the
>> interrupt-parent for the soc, the kernel seems to hang and not produce
>> any output on the serial port[0]. I tried to enable earlyprintk, but
>> no luck getting a trace. Reversing this change, gets the board
>> booting[1], but obviously isn't using the gpc which is needed for PCIe
>> support as I understand it. I assume you've tested these changes on a
>> imx7d-sdb and are not seeing a similar issue? You can find the patches
>> I've picked on top of v4.11-rc5 here[2], any idea what might be the
>> issue?
>
> Thanks for the report.

No problem.

> It seems this series depends on the drivers/soc/imx/gpcv2.c patches
> that landed into linux-next.

Are you referring to the following patches?

"dt-bindings: Add GPCv2 power gating driver"
"soc: imx: Add GPCv2 power gating driver"

I've pulled these patches from Shawn's tree to test with, but still
not able to get anything functional. Is there another series I should
be looking at?

Thanks,

Tyler
