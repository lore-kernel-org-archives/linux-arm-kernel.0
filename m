From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 14 May 2010 12:09:27 +0200
Subject: PXA/8250 UART Conflicts
In-Reply-To: <20100513214057.GA18868@rainbow>
References: <3117D78B-5443-48B5-88BC-83EEB8F709F9@prograde.net>
	<20100511161206.GB32186@n2100.arm.linux.org.uk>
	<20100513214057.GA18868@rainbow>
Message-ID: <AANLkTiluX0mpeSi4TzBMCPhMzIjXEEx5mwvavFmRqNy4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 13, 2010 at 11:40 PM, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> On 17:12 Tue 11 May ? ? , Russell King - ARM Linux wrote:
>> On Tue, May 11, 2010 at 11:00:36AM -0400, Michael Cashwell wrote:
>> > I'd like the tty layer to just assign the minor numbers in sequence,
>> > first come first served. But I don't see how to get that. Or is there
>> > some platform way to influence the tty range requested?
>>
>> It's just plain not supported. ?You can't have two different tty drivers
>> using the same namespace and have it work.
>>
>> Unfortunately, earlier on it was the opinion that "ttyS" means "serial
>> driver" and therefore "we shall use the ttyS namespace for our SoC
>> driver". ?And this is the resulting mess that it causes.
>
> Yup, that's a long standing bug (and still not fixed). I remember I first
> happened to stumble upon it about three years ago and it's already been old
> back then. In fact it's a general PITA on any PXA board with PCMCIA/CF
> slot (handhelds, for example, but not only) when you trying to use some
> serial PCMCIA peripherals (e.g. GPSes, wired and wireless modems,
> RS232 converters, maybe even bluetooth dongles). With 8250 enabled as a module
> and PXA serial built-in it simply doesn't works.
>
> Openembedded guys for ages have patched kernel with hacks like these to solve
> this problem:
> http://git.openembedded.org/cgit.cgi/openembedded/plain/recipes/linux/linux-rp-2.6.26/pxa-serial-hack.patch
>
> Though, personally I'm preferring solution with moving PXA ports into
> another namespace (be it ttySA, or ttyPXA, or whatever). So maybe it's
> time to finally make a first step and apply something like Russell's patch now,
> and then gradually deprecate usage of old ttyS namespace for PXA, or maybe
> even left it as a non-default config option (so users who can't reconfigure
> their userspace/bootloader can still use newer kernels with old behaviour).
>
> I'd like to hear some comments on the subject from Eric (adding him to Cc:)
>

No comment so far. Though I'm not sure if it might be time to bring pxa back
to 8250 :-)
