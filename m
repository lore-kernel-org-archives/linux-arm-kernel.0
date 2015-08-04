From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 04 Aug 2015 21:12:54 +0200
Subject: next-20150729 build: 2 failures 49 warnings (next-20150729)
In-Reply-To: <20150804173849.GD20873@sirena.org.uk>
References: <E1ZKPJk-0007VU-Fg@optimist>
 <20150729124410.GE20130@sirena.org.uk> <20150804173849.GD20873@sirena.org.uk>
Message-ID: <17C303E7-B358-486E-9E0F-83CF58F28481@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On August 4, 2015 7:38:49 PM CEST, Mark Brown <broonie@kernel.org> wrote:
>On Wed, Jul 29, 2015 at 01:44:10PM +0100, Mark Brown wrote:
>> On Wed, Jul 29, 2015 at 12:14:36PM +0100, Build bot for Mark Brown
>wrote:
>
>> Today's linux-next fails to build an arm64 allmodconfig due to:
>
>> > 	arm64-allmodconfig
>> > ../include/linux/platform_device.h:245:1: error: type defaults to
>'int' in declaration of 'module_init' [-Werror=implicit-int]
>> > ../include/linux/platform_device.h:250:1: error: type defaults to
>'int' in declaration of 'module_exit' [-Werror=implicit-int]
>
>> caused by c84e358718a66f76 (soc: Mediatek: Add SCPSYS power domain
>> driver) which does not include module.h.  Arguably platform_device.h
>> should do that, though it's only an issue if the macro is used so...
>
>This is still breaking the build and the fix should be trivial - is
>there any ETA for a fix getting into -next?

I send a fix to arm at kernel.org but no reply yet. (sorry I'm not in front of a computer so I can't send you the link right now).

I will send a pull request tomorrow, let's see if that helps...

Matthias
