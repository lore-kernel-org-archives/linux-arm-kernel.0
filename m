From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 9 May 2012 23:06:15 +0800
Subject: [PATCH 06/10] ARM: Samsung: Modify s3c64xx_spi{0|1|2}_set_platdata
 function
In-Reply-To: <20120509143330.GV3955@opensource.wolfsonmicro.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-7-git-send-email-thomas.abraham@linaro.org>
 <20120509085617.GB28702@sirena.org.uk>
 <201205091110.15224.heiko@sntech.de>
 <20120509105500.GG3955@opensource.wolfsonmicro.com>
 <CAJuYYwSMant-44jvvyeefojmur7vCvKLeEPWEK52pqUTB4RZkg@mail.gmail.com>
 <20120509143330.GV3955@opensource.wolfsonmicro.com>
Message-ID: <CAJuYYwRFdXKJTgiBjjPCAv=aneN5w_NL5PABamGacNhzjfxgNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 May 2012 22:33, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 09, 2012 at 10:22:26PM +0800, Thomas Abraham wrote:
>> On 9 May 2012 18:55, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
>
>> > Yes, that's the normal way of handling this and is actually what the
>> > code was originally doing - there's a bunch of ifdefed devices in
>> > plat-samsung/devs.c. ?You usually have to do this anyway as the IPs move
>> > about so the resources need changing.
>
>> In addition to the setting the name, the platform data is also
>> assigned at runtime. Adding multiple platform devices means that we
>> add lot more code in setting up the platform data. And since we are
>> moving towards adopting dt, these would anyway go away when we have
>> all the platforms migrated to dt.
>
> With your refactoring the only platform data that's left is the /CS?

The nCS line is not part of the platform data. It is part of the spi
board info. There are three elements in the platform data after the
re-factoring which is used on only non-dt platforms - (a) the clock
source number to be selected as the bus clock in the spi controller's
clock mux, (b) the number of nCS lines emulated by the controller and
(c) the gpio setup callback function. With device tree, all this
information is obtained from the device tree.

Thanks,
Thomas.
