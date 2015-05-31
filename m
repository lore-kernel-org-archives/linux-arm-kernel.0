From: linux-arm@myspectrum.nl (Jeroen Hofstee)
Date: Mon, 01 Jun 2015 00:15:51 +0200
Subject: OMAP baseline test results for v4.1-rc5
In-Reply-To: <5569DDB3.2040802@myspectrum.nl>
References: <alpine.DEB.2.02.1505301534250.26925@utopia.booyaka.com>
 <5569DDB3.2040802@myspectrum.nl>
Message-ID: <556B8817.7080305@myspectrum.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30-05-15 17:56, Jeroen Hofstee wrote:
> Hello Paul,
>
> On 30-05-15 17:50, Paul Walmsley wrote:
>> Here are some basic OMAP test results for Linux v4.1-rc5.
>> Logs and other details at:
>>
>> http://www.pwsan.com/omap/testlogs/test_v4.1-rc5/20150529162206/
>>
>
> The cmt3517 seems to have these some In-Band errors.
> Do you happen to know where these are coming from?
>

git bisect + some workarounds seem to indicate:

d744ce37b721d6678f420ba0fb058f615eb015b6 is the first bad commit
commit d744ce37b721d6678f420ba0fb058f615eb015b6
Author: Tero Kristo <t-kristo@ti.com>
Date:   Tue Feb 24 16:22:45 2015 +0200

     ARM: dts: omap3: add minimal l4 bus layout with control module support

     This patch creates an l4_core interconnect for OMAP3, and moves some
     of the generic peripherals under it. System control module nodes are
     moved under this new interconnect also, and the SCM clock layout
     is changed to use the renamed SCM node as the clock provider.

     Signed-off-by: Tero Kristo <t-kristo@ti.com>
     Reported-by: Tony Lindgren <tony@atomide.com>

I haven't looked further into it yet,

Regards, Jeroen
