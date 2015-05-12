From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Tue, 12 May 2015 09:25:48 -0600
Subject: "drm: Add reference counting to blob properties" breaks Tegra124
 Jetson TK1 in linux-next
In-Reply-To: <CAPj87rOwzD7-g+GRkGpPXi+ayafmr8E=mbTK3j7cgCAkXCFt2g@mail.gmail.com>
References: <55517AE5.30700@nvidia.com>
 <CAPj87rOwzD7-g+GRkGpPXi+ayafmr8E=mbTK3j7cgCAkXCFt2g@mail.gmail.com>
Message-ID: <55521B7C.3030708@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 05/12/2015 03:06 AM, Daniel Stone wrote:
> Hi Paul,
>
> On 12 May 2015 at 05:00, Paul Walmsley <pwalmsley@nvidia.com> wrote:
>> Tegra124 Jetson TK1 hangs during boot in next-20150508 and beyond:
>>
>> http://nvt.pwsan.com/experimental/linux-next/testlogs/test_next-20150508/20150508101018/boot/tegra124-jetson-tk1/tegra124-jetson-tk1/tegra_defconfig_log.txt
>> http://nvt.pwsan.com/experimental/linux-next/testlogs/test_next-20150511/20150511004533/boot/tegra124-jetson-tk1/tegra124-jetson-tk1/tegra_defconfig_log.txt
>>
>> Reverting commit 672cb1d6aec7da2799afd1b529d5136d84ed2561 ("drm: Add
>> reference counting to blob properties") gets it booting again:
>>
>> http://nvt.pwsan.com/pub/pwalmsley-tester/testlogs/test_20150511204703_3838232431c2636ff539f2354c630c0ca3d4b7ad/20150511204703/boot/tegra124-jetson-tk1/tegra124-jetson-tk1/tegra_defconfig_log.txt
>>
>> I'm not a DRM expert but maybe one of you knows what's going on here?
> Thierry found and fixed the rather stupid bug: not using the cached
> 'dev' variable in the one place it would've been useful!
>
> http://paste.debian.net/175522/ is the fix, which has been squashed in
> to the branch and should appear in -next from today.
>
> Thanks for the report.

Great!  Thanks everyone for the very fast fix.


- Paul
