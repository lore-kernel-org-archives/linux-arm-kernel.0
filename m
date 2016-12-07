From: labbott@redhat.com (Laura Abbott)
Date: Wed, 7 Dec 2016 13:56:58 -0800
Subject: [RFC PATCH 00/23] arm: defconfigs: use kconfig fragments
In-Reply-To: <2155947.mOKhpZPiAn@wuerfel>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
 <8292218.3BDisRkZdU@wuerfel>
 <CAOesGMi_mLG+tS0Ya8G9KLO_sUYGtLmgcvFfpn0Nwbd-KMKOrQ@mail.gmail.com>
 <2155947.mOKhpZPiAn@wuerfel>
Message-ID: <9c0ed8c5-406a-9304-48b5-6f11f3940271@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/2016 01:35 PM, Arnd Bergmann wrote:
> On Wednesday, December 7, 2016 1:14:02 PM CET Olof Johansson wrote:
>>>
>>> - A "debug" fragment would be nice, to turn on common options that
>>>   add a lot of useful runtime checks at the expense of performance
>>>   or code size.
>>
>> Hmm, some of these might work but several useful debug options (in
>> particular DEBUG_LL for early errors) are per-system/platform.
> 
> I was thinking mostly of architecture-independent options, i.e.
> the stuff that is in lib/Kconfig.debug but isn't too expensive
> to be run in a regular test environment. Enabling those
> for a build/boot automation environment would be particularly
> useful as you'd catch more bugs that get introduced through
> a random patch.
> 
>>> - A "distro" fragment that turns on all loadable modules that are
>>>   enabled by common distributions (e.g. two or more of
>>>   debian/fedora/opensuse/gentoo), to let you build a drop-in
>>>   replacement kernel for a shipping distro. This would also allow
>>>   the distros to strip their own config files and just specify
>>>   whatever differs from the others.
>>
>> Keeping this in sync with the distro kernel could be a bit awkward
>> (and possibly churny).
> 
> It would certainly need buy-in from distro maintainers. I've discussed
> this with Laura Abbott in the past, and she was interested in
> principle.
> 
> 	Arnd
> 

Yes, I've gotten the request from multiple people now about having
some Fedora config in mainline. I agree that churn and keeping in
sync would be a concern. For a first pass, I was going to propose
a minimal set of options that are unlikely to need to churn. Once
those are agreed on, everything else could become a separate .config.
My plan was to send a patch out around -rc2/-rc3 each cycle to sync
up.

Thanks,
Laura
