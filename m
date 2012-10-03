From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Oct 2012 09:27:31 -0600
Subject: [PATCH V6 2/2] video: drm: exynos: Add device tree support
In-Reply-To: <CAL1wa8egdA=1iu8Jr-TQLnSweOQoCL=TD4cvo1BHHNn9UyOSEQ@mail.gmail.com>
References: <1348226536-22899-1-git-send-email-l.krishna@samsung.com>
 <1348226536-22899-3-git-send-email-l.krishna@samsung.com>
 <505BF79A.8060802@wwwdotorg.org>
 <CAL1wa8eOA6eV-9EoeUFrSFaFwq5sEVnYXn9yKnPRv=0mSU5WvQ@mail.gmail.com>
 <5069C2DC.8080905@wwwdotorg.org>
 <CAL1wa8egdA=1iu8Jr-TQLnSweOQoCL=TD4cvo1BHHNn9UyOSEQ@mail.gmail.com>
Message-ID: <506C5963.50902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2012 10:06 PM, Leela Krishna Amudala wrote:
> On Mon, Oct 1, 2012 at 9:50 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 09/30/2012 11:29 PM, Leela Krishna Amudala wrote:
>>> Hello Stephen Warren,
>>>
>>> The binding names that I use in my dts file should match with the
>>> names given in http://lists.freedesktop.org/archives/dri-devel/2012-July/024875.html
>>> right?
>>
>> I don't think so; the binding in that link is for example:
>>
>>> + - xres, yres: Display resolution
>>> + - left-margin, right-margin, hsync-len: Horizontal Display timing parameters
>>> +   in pixels
>>> +   upper-margin, lower-margin, vsync-len: Vertical display timing parameters in
>>> +   lines
>>> + - clock: displayclock in Hz
>>
>> i.e. a bunch of separate properties, one for each value needed to
>> describe the display timing. However, your patch contains:
> 
> I mean to say that even I have to use separate properties for each one
> instead of grouping them.
> Also the names should match with the ones given in the example..?

Yes. The patch I pointed to isn't supposed to be just an example, but
/the/ standard way of representing display timings.
