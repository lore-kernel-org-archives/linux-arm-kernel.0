From: jrnieder@gmail.com (Jonathan Nieder)
Date: Mon, 6 Feb 2012 16:31:47 -0600
Subject: [regression] Re: Enabling runtime P2V by default
In-Reply-To: <20110810092206.GE10121@e102144-lin.cambridge.arm.com>
References: <1312918898-11894-1-git-send-email-linus.walleij@stericsson.com>
 <20110810091635.GF1831@n2100.arm.linux.org.uk>
 <20110810092206.GE10121@e102144-lin.cambridge.arm.com>
Message-ID: <20120206223147.GA3760@burratino>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
> On Wed, Aug 10, 2011 at 10:16:35AM +0100, Russell King - ARM Linux wrote:
>> On Tue, Aug 09, 2011 at 09:41:38PM +0200, Linus Walleij wrote:

>>> From: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> This works like a charm so I'll just default-select it.
>>
>> Well, we can remove the EXPERIMENTAL status of this option now.  This
>> raises the question is whether we should now default it to 'y' - I
>> think we should.  Anyone have any objections?
>
> I've been running with this option enabled for the collection of ARM boards
> I have and the only problem I have encountered was related to u-boot loading
> at the wrong address.

Hm, another u-boot problem was found[1].  On the affected machines it
prevents booting a compressed kernel (but uncompressed kernels are
fine) unless CONFIG_ARM_PATCH_PHYS_VIRT is disabled or u-boot is
patched.

> So I'm all for enabling it by default, especially since it will force out
> any remaining issues for boards where this hasn't been used extensively.

Looks like it worked. ;-)

So, what now?  Is there anything the kernel can do to work around
this, or should we just live with the regression until people patch
their u-boot?

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.comp.boot-loaders.u-boot/124051/focus=124062
https://bugzilla.kernel.org/show_bug.cgi?id=42680
