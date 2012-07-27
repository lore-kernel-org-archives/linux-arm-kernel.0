From: b32955@freescale.com (Huang Shijie)
Date: Fri, 27 Jul 2012 18:21:56 +0800
Subject: [PATCH v2 3/3] ARM: imx_v6_v7_defconfig: Select MXS_DMA
In-Reply-To: <50125FC3.4040603@de.bosch.com>
References: <1343215100-24005-1-git-send-email-festevam@gmail.com>
 <1343215100-24005-3-git-send-email-festevam@gmail.com>
 <CAMiH66EA4O0s8hfXkr_SJ56+q7eZ8w0=3C1r_C+m2Os1RxprmA@mail.gmail.com>
 <CAOMZO5BfT+_7x4F96Kvqtq5STXxw2Y9CxbCCAc_UnZ-3wy0qxg@mail.gmail.com>
 <CAMiH66FUxiw0B8iD5rYi=nUX0VYZBzOKifXKfTqd1RmSHhC80g@mail.gmail.com>
 <CAOMZO5DUN5d_aN=j8bfj6n3of=r2A-mu+jqNXCR-4HVTA7kS6Q@mail.gmail.com>
 <CAMiH66HCih0=zWqhwAGj+rVTW7-9vNO8y-6tC+p8R7yg=+sojw@mail.gmail.com>
 <CAOMZO5BziYJVUzniUoZmdFejso+6dBOc6QtTuzbbMyVOXuOFDQ@mail.gmail.com>
 <CAMiH66E9gJJ7f=wKJ8Ondegj=+WUYYuDA0iB8mhNoWBRNWXKsQ@mail.gmail.com>
 <50125FC3.4040603@de.bosch.com>
Message-ID: <50126BC4.2010709@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?07?27? 17:30, Dirk Behme ??:
> On 26.07.2012 13:32, Huang Shijie wrote:
>> On Thu, Jul 26, 2012 at 7:08 AM, Fabio Estevam <festevam@gmail.com> 
>> wrote:
>>> On Thu, Jul 26, 2012 at 7:56 AM, Huang Shijie <shijie8@gmail.com> 
>>> wrote:
>>>> On Thu, Jul 26, 2012 at 6:53 AM, Fabio Estevam <festevam@gmail.com> 
>>>> wrote:
>>>>> On Wed, Jul 25, 2012 at 11:24 PM, Huang Shijie <shijie8@gmail.com> 
>>>>> wrote:
>>>>>
>>>>>> But you have added "depend on MXS_DMA". So If you do not select the
>>>>>> mxs-dma, you can not see the
>>>>>> gpmi-nand.
>>>>>> that's why i think this patch is not needed.
>>>>> So how CONFIG_MXS_DMA would be selected if not via defconfig?
>>>> Use the make menuconfig ARCH=arm:
>>>>
>>>> "device drivers"-->"DMA engine support" -->"mxs dma support"
>>> I prefer to have selected in the defconfig by default instead.
>>>
>>> It is not obvious for the end user that they need to manually select
>>> this option.
>>>
>>> mxs_defconfig also selects CONFIG_MXS_DMA.
>> In mx23/mx28, the mxs-dma has many users, so it's proper to make it 
>> default.
>>
>>> Can't we do the same here and let imx_v6_v7_defconfig be built again?
>> Shawn, do you have any opinion about this?
>
> First, I think Shawn is on holiday at the moment.
>
> Second, recent kernel mainline from today building imx_v6_v7_defconfig 
> is broken due to this.
Sascha did not CC to me when he submitted the patch 3def84ed9 "ARM: 
imx_v6_v7_defconfig: ..".

I would check this patch if he CCed to me.

BR
Huang Shijie


>
> So to make it build again, we have to enable CONFIG_MXS_DMA anyhow. As 
> it seems that GPMI_NAND needs it to build, I would vote for the
>
> depends on MXS_DMA
>
> fix proposed by Richard
>
> http://www.spinics.net/lists/arm-kernel/msg186111.html
>
> Anyhow, any chance to get the kernel mainline fixed asap?
>
> Many thanks and best regards
>
> Dirk
>
>
