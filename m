From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Fri, 5 Sep 2014 19:26:42 +0530
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <CAEC9eQOMd7ME5KiG2QHCf3TMJAwSxLUgGpmFrpw_HQT4me9YWg@mail.gmail.com>
References: <20140905115704.GO13515@arm.com> <20140905122232.GP13515@arm.com>
 <CAEC9eQOMd7ME5KiG2QHCf3TMJAwSxLUgGpmFrpw_HQT4me9YWg@mail.gmail.com>
Message-ID: <CAFp+6iF7EbcVqrDKpP4KbYVTEFMD7Jvp9B9kXbAQjpQN3vM=aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,


On Fri, Sep 5, 2014 at 7:16 PM, Ajay kumar <ajaynumb@gmail.com> wrote:
> Hi Will,
>
> On Fri, Sep 5, 2014 at 5:52 PM, Will Deacon <will.deacon@arm.com> wrote:
>> [Looks like it's not just Rutland that can't spell the address of the
>>  mailing list today. Fixed here, so please use this post in any replies].
>>
>> On Fri, Sep 05, 2014 at 12:57:04PM +0100, Will Deacon wrote:
>>> Hi all,
>>>
>>> I'm one of the few, foolish people to try running mainline on my 5250-based
>>> Samsung Chromebook (snow). I can live without wireless, usb3 and video
>>> acceleration, so actually it makes a reasonable development platform for
>>> doing A15-based (micro)-architectural work.
>>>
>>> However, since 3.15 I've not been able to boot *any* mainline kernels on
>>> this board. I did mean to report this earlier, but I have other machines
>>> that can run mainline so this has fallen by the wayside.
>>>
>>> The problems started with 3.16, where simple-fb would fail to initialise
>>> and I lost my display. Note that I don't have a serial console on this
>>> machine (I looked at the PCB and there's no way I can solder one of those
>>> myself :) I bisected the issue at the time, and I could get my display back
>>> by removing some of the new regulator and hdmi properties from the DT. At
>>> that point, I could boot, but DMA didn't initialise for the MMC controller
>>> so I couldn't mount my root filesystem.
>>>http://www.spinics.net/lists/dri-devel/msg66740.html
>>> With 3.17-rc3, it seems a lot worse -- I don't get any output after nv-uboot
>>> (i.e. the nv-uboot screen just remains on the display, with the last line
>>> reading "Stashed 20 records").

It's unfortunate that you have not been able to use display on snow.
As Ajay has mentioned in the previous mail, there are still some in-flight
patches needed to get display up and running.
And since you don't have a serial console available with your machine,
the last print with you see is from the u-boot only.

>>>
>>> I'd usually try to debug this a bit further, but without a console it's
>>> really painful to get anywhere. I've been working with 3.15, but now I'm
>>> having to backport patches when I want to test them, which is more effort
>>> than I can be bothered with.
>>>
>>> Is anybody else running mainline on this device and are these known/fixed
>>> problems?
> AFAIK, ARM chromebooks use DRM based display drivers and the required
> patches are still not merged:
> http://www.spinics.net/lists/dri-devel/msg66740.html
>
> Corresponding DT patches are also still not merged:
> http://www.spinics.net/lists/arm-kernel/msg358324.html
> http://www.spinics.net/lists/arm-kernel/msg358325.html
>
> There is a patch for configs as well:
> https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg35828.html
>
> Try these patches(I hope they will apply directly on 3.17-rc3) and you should
> be able to use display on snow.

We have pushed 3.17-rc3 kernel with above mentioned patches to github [1]
Please use that, and in case you have some other requirements let us know.

[1] https://github.com/exynos-reference/kernel/tree/exynos5-v3.17-rc3-display



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
