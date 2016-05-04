From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 4 May 2016 07:25:42 -0500
Subject: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
In-Reply-To: <20160504071801.GA17045@amd>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <20160429181248.GW19428@n2100.arm.linux.org.uk> <20160504071801.GA17045@amd>
Message-ID: <CAL_JsqJ4Pzuip9VUpwryy_xK6XSZ6E+kus3wD=T4wcTHav=9iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 4, 2016 at 2:18 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Fri 2016-04-29 19:12:48, Russell King - ARM Linux wrote:
>> On Fri, Apr 29, 2016 at 10:32:15AM -0700, Douglas Anderson wrote:
>> > This series picks patches from various different places to produce what
>> > I consider the best solution to getting consistent mmc and mmcblk
>> > ordering.
>> >
>> > Why consistent ordering and why not just use UUIDs?  IMHO consistent
>> > ordering solves a few different problems:
>>
>> NAK.  Really.  Use UUIDs, that's the proper solution here.
>
> Except that UUIDs do not solve the problem.
>
> You have just booted of nfsroot, and you want to format u-SD card in
> the external slot. How do you do that?

The same way you format a USB stick when you insert it.

If you have built-in versus removable, then we should expose that
information to userspace rather than some arbitrary encoding in DT
that 0 means built-in and 1 means removable. Or if you have multiple
slots, then use "label" to provide meaningful slot names.

Rob
