From: jenskuske@gmail.com (Jens Kuske)
Date: Wed, 27 Jan 2016 15:36:21 +0100
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <20160127103714.58312b152adb4148bae2f93b@free.fr>
References: <20160127084607.665fb8c38eeb5733ce4232da@free.fr>
 <CAGb2v65FUhNC-d-YT=-2adNHHT6b1JvGoNTFLfBX_xBSnuOsTg@mail.gmail.com>
 <20160127103714.58312b152adb4148bae2f93b@free.fr>
Message-ID: <56A8D5E5.30701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/16 10:37, Jean-Francois Moine wrote:
> On Wed, 27 Jan 2016 16:18:53 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
> 
>> Hi,
> 
> Hi ChenYu,
> 
>> On Wed, Jan 27, 2016 at 3:46 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
>>> Hi Jens,
>>>
>>> My H3 machine (OPI2) cannot boot with the PLL6 (periph0) as defined
>>> in the kernel 4.5-rc1. As there is no UART, I don't know what is wrong.
>>>
>>> But, applying your old patch
>>>
>>> [PATCH v4 1/6] clk: sunxi: Let divs clocks read the base factor clock name from devicetree
>>> (https://lkml.org/lkml/2015/10/27/532)
>>>
>>> makes everything work correctly again (thanks to other patches, I have
>>> 4 CPUs, USB, thermal sensor and video).
>>>
>>> Any idea?
>>
>> What kernel and DTS are you using? What other patches have you applied?
> 
> About the clock problem, I tried the 4.5-rc1 kernel with its included DTs
> (sun8i-h3-orangepi-plus.dts) without patch. No UART.
> Changing the PLL6 (and the phandles in the DT) makes the UART work.

Hi,

That sounds strange, 4.5-rc1 is working perfectly fine for me too.

I doubt the patch you linked is responsible for making it work, it only
removes the hardcoded output-names. If your DT isn't messed up this
isn't relevant at all since pll8, the initial reason for this patch, is
only a dummy clock for now. Are you sure you are using a clean v4.5-rc1
without any own modifications?

Jens
