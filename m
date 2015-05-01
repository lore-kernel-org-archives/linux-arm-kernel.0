From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 01 May 2015 11:30:18 +0200
Subject: [PATCH 0/4] clk: si5351: Some fixes
In-Reply-To: <20150501111406.0aa23c7b@armhf>
References: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150501111406.0aa23c7b@armhf>
Message-ID: <554347AA.3070502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.05.2015 11:14, Jean-Francois Moine wrote:
> On Thu, 30 Apr 2015 19:45:50 +0200
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>> For Si5351 clock driver, Michael Welling and Jean-Francois Moine reported
>> issues with recent v4.x kernels due to broken/missing/wrong parent clock
>> claming. This patch set now deals with the issues reported.
>>
>> Patch 1 amends the binding documentation mention clock-names property
>> for the "xtal" and "clkin" parent clock inputs of Si5351 variants.
>>
>> Patch 2 adds the clock-names property for the SolidRun CuBox using Si5351
>> with a fixed oscillator connected to "xtal" input.
>>
>> Patch 3 reworks the way we claim parent clocks by using devm_clk_get()
>> for both DT and platform_data based registration. Also, properly check
>> for errors returned by devm_clk_get() and prepare/enable the parent clocks.
[...]
>
> I applied the patches 2 and 3, and the audio and video in the Cubox
> work fine again. Thanks.

Ok, good. You mentioned that on v3.19-rc1 it still "works" i.e. despite
the broken/missing clk_get/clk_prepare_enable?

Can you check the stable (v3.19, v4.0) versions and see how far we
should backport the fix?

Sebastian
