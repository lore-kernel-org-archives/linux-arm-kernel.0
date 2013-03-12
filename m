From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Mar 2013 12:23:32 -0600
Subject: [PATCH v4 0/2] Uncompress debug for multiplatform
In-Reply-To: <20130312040242.GF25910@S2101-09.ap.freescale.net>
References: <1363001737-8745-1-git-send-email-shawn.guo@linaro.org>
 <20130311170350.GM4977@n2100.arm.linux.org.uk>
 <513E149A.2060704@wwwdotorg.org>
 <20130312040242.GF25910@S2101-09.ap.freescale.net>
Message-ID: <513F72A4.8020309@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2013 10:02 PM, Shawn Guo wrote:
> On Mon, Mar 11, 2013 at 11:30:02AM -0600, Stephen Warren wrote:
>> On 03/11/2013 11:03 AM, Russell King - ARM Linux wrote:
>>> On Mon, Mar 11, 2013 at 07:35:35PM +0800, Shawn Guo wrote:
>>>> Instead of giving zero support of uncompress debug for multiplatform
>>>> build, the series turns uncompress debug into one part of DEBUG_LL
>>>> support.  When DEBUG_LL is turned on for a particular platform,
>>>> uncompress debug works too for that platform.
>>>>
>>>> OMAP is an exception here.  OMAP low-level debug code places data
>>>> in the .data section, and that is allowed in decompressor.  That's
>>>> why Kconfig symbol DEBUG_UNCOMPRESS that controls multiplatform
>>>> uncompress debug support is defined with !DEBUG_OMAP2PLUS_UART.
>>>>
>>>> Changes since v3:
>>>>  - Create Kconfig symbol DEBUG_UNCOMPRESS for building in
>>>>    multiplatform uncompress debug support, so that we can leave
>>>>    out the platform which is part of multiplatform but not ready
>>>>    for being part of uncompress debug like OMAP example.
>>>
>>> Wasn't Tegra also having problems with this as well?
>>
>> Tegra isn't converted to multi-platform yet. I hope to in 3.10.
> 
> Yeah, that's why I did not touch Tegra as the series is based on
> v3.9-rc1 where Tegra hasn't been part of multi-platform yet.
> 
> But I just noticed that debug-macro.S for Tegra has been renamed to
> debug/tegra.S, and we already know it will be broken when multi-platform
> is enabled together with this series for Tegra.

Was that because the code touches .data? Perhaps I can get away with
using some hard-coded IRAM location or something.
