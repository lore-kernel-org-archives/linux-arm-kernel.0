From: chasedouglas@gmail.com (Chase Douglas)
Date: Tue, 18 May 2010 08:44:58 -0400
Subject: [RFC PATCH 0/3] ep93xx i2s audio
In-Reply-To: <4BF21B67.8090404@bluewatersys.com>
References: <4BF21B67.8090404@bluewatersys.com>
Message-ID: <AANLkTikALpXrPznJBGWItLbAVPWiupPmzV2NR_XJq7-h@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 12:45 AM, Ryan Mallon <ryan@bluewatersys.com> wrote:
> Hi all,
>
> The following patch series adds support for i2s audio on the ep93xx,
> with the Snapper CL15 used as an example implementation. The driver is
> basically working, but still incomplete and needs some tidy up before it
> will be accepted for mainline. I am posting the patches to get feedback
> from others as to how well it works on their boards and ideas to improve
> the code.
>
> The following issues still exist:
> ?- The setting of SDIV/LRDIV is ugly since it requires modifying one of
> the clock registers from the audio driver.

I'm not too sure what to do here myself, this isn't my normal domain.

> ?- Audio capture has not been tested

Can you test it? I would think it should be somewhat simple to test,
and it's better to have working code in the kernel.

> ?- Sometimes playback (ie aplay) results in noise. Killing the process
> and trying again will result in correct playback.

Hrm. I don't remember having this issue way back.

> ?- Some empty functions can probably be removed

I tried to find stuff you can remove, but I only found one.

> ?- Not sure if I2SONSSP/AC97 should be a function argument, or a Kconfig
> option (opinions please).

The function argument is better. Think of the case where you have one
kernel that runs on two separate machines. This option needs to be
settable at runtime.

Awesome work! I'm glad someone else has been able to take Lennert and
my code and make it useful again. I've got some notes interspersed
with your patches, please review them.

Thanks!

-- Chase
