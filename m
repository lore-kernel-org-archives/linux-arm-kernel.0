From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 9 Apr 2015 09:14:40 -0600
Subject: [PATCH] coresight: etb10: Print size of buffer we fail to allocate
In-Reply-To: <20150409145558.GW6023@sirena.org.uk>
References: <1428531327-16902-1-git-send-email-broonie@kernel.org>
 <CANLsYkzoj5nPs2dnejOsDgEHZXArbXq5s6B7Cp3P1siu0Vv8YA@mail.gmail.com>
 <20150409145558.GW6023@sirena.org.uk>
Message-ID: <CANLsYkzKJM0c4cw9=6bi=ZQYk9K6f-BLm7bSoUKUjgVNS5K_VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 April 2015 at 08:55, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Apr 09, 2015 at 08:46:55AM -0600, Mathieu Poirier wrote:
>
>> I'll take this patch but will rework the commit message a little.  If
>> the power domains are not setup properly the device won't show up on
>> AMBA and as such won't get probed.
>
> This depends on what the hardware does and how the device is registered
> - if the device is registered with an ID provided (which you can do)
> then AMBA won't bother reading the ID back and verifying that it's
> correct so there's no interaction with the hardware until we hit the
> driver.

Indeed possible, but in that case you'll get a core dump or the kernel
will simply hang waiting on the memory area being read.

>
> I've not checked the DT case, though it doesn't seem like there's any
> check that the compatible string matches the ID read from the hardware
> which is a bit interesting...

This is something I've been meaning to add for a while now but never
got around to do it.
