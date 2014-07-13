From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sun, 13 Jul 2014 15:36:52 +0200
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <20140712194903.GB6800@sirena.org.uk>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <1405086308-1461192-4-git-send-email-arnd@arndb.de>
 <53C153FF.4090705@metafoo.de> <20140712194903.GB6800@sirena.org.uk>
Message-ID: <53C28B74.6010401@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2014 09:49 PM, Mark Brown wrote:
> On Sat, Jul 12, 2014 at 05:27:59PM +0200, Lars-Peter Clausen wrote:
>> On 07/11/2014 03:45 PM, Arnd Bergmann wrote:
>
>>> As a prerequisite for moving s3c64xx into multiplatform configurations,
>>> we need to change the smartq audio driver to stop using hardcoded
>>> gpio numbers from the header file, and instead pass the gpio data
>>> through platform_data.
>
>> This should be using the gpiod API. The gpiod API allows you to pass the
>> GPIOs without having to add a platform_data struct.
>
> OTOH that's a more invasive change that's harder to do mechanically -
> I'm not sure it's sensible to insist on someone doing it for generic
> cleanups (rather than actively working with the particular platform).

I don't think it is more invasive than using platform data. I did the same 
recently for jz4740 qi-lb60[1] and the changes in the patch are fairly trivial. 
The non-descriptor API is deprecated, so this even if this patch is applied as 
is sooner or later somebody will mechanically convert it to the descriptor API.

- Lars

[1] 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=218e18a3728507ee82ed2eb10c789671a00e34bd
