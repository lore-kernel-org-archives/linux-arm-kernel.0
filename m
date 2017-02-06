From: flatmax@flatmax.org (Matt Flax)
Date: Tue, 7 Feb 2017 07:25:48 +1100
Subject: [alsa-devel] [PATCH] ASoC: bcm2835: Increase channels_max to 8
In-Reply-To: <20170206164359.vnyxa5iumtslxisy@sirena.org.uk>
References: <1485992264-9058-1-git-send-email-flatmax@flatmax.org>
 <20170204154944.timxhmmibc4kngly@sirena.org.uk>
 <a7f5de09-b07b-638d-466f-525e68ebf0f9@flatmax.org>
 <20170205163451.4x3svwbqdqlfc7t4@sirena.org.uk>
 <aa6b9cbd-e033-eee6-d7f8-8ba8c8e611ab@flatmax.org>
 <20170206164359.vnyxa5iumtslxisy@sirena.org.uk>
Message-ID: <1ca503f5-f42d-3254-9ecc-14e56f034cc2@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/17 03:43, Mark Brown wrote:
> On Mon, Feb 06, 2017 at 07:37:03AM +1100, Matt Flax wrote:
>> On 06/02/17 03:34, Mark Brown wrote:
>>> Looking at the driver it may be possible for the hardware to do DSP
>>> modes at which point this gets much easier but right now it only has I2S
>>> support, I've got a feeling that the other end of the link may actually
>>> be running in a DSP mode.
>> You've got it !
> If you're actually using the device in DSP mode you need to be showing
> that in the driver, not claiming that it's I2S.
>
>> I haven't looked into why, but I am getting the correct channel mapping
>> under the hood. To me that is a concern of the higher up levels of the ALSA
>> driver - it was a pleasant surprise when it worked nicely, because to me it
>> indicated a robustly coded system.
> If the external device is running in DSP mode it'll work fine.
>
>> My next patch is to allow DSP modes in this I2S driver. I wanted to make
>> sure that this got through first however.
> This is the wrong way round.
>
>> The majority of these other concerns you mention are controlled at the
>> machine driver level.
> The driver should be checking for errors, it shouldn't be silently
> accepting incorrect configurations - we shouldn't be forcing all the
> machine drivers to replicate code for this, or requiring modifications
> to machine drivers because a new feature has been added to one of the
> drivers it uses.
>
I understand, that makes sense. I will submit a new patch which adds the 
DSP mode requirement and guards against misconfiguration.

Thank you for your guidance.
Matt
