From: olof@lixom.net (Olof Johansson)
Date: Fri, 2 Jun 2017 12:33:02 -0700
Subject: [GIT PULL] ARM: realtek: arm64 for v4.12
In-Reply-To: <CAK8P3a2_RGZ14csNEhitsSoqFbj7UJjGbPELbpMdjpYJm4vrpQ@mail.gmail.com>
References: <20170525120404.32034-1-afaerber@suse.de>
 <20170602002831.GO13314@localhost>
 <45e8f92d-0680-2983-067f-39adecf7503f@suse.de>
 <CAK8P3a2_RGZ14csNEhitsSoqFbj7UJjGbPELbpMdjpYJm4vrpQ@mail.gmail.com>
Message-ID: <CAOesGMiAKw+g_Q5B4gkTiyuEeUJ3n+wn4UgDA75_q=q7vrCu7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[again in plain text. Grr gmail.]


On Fri, Jun 2, 2017 at 6:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jun 2, 2017 at 2:32 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> Hi Olof,
>>
>> Am 02.06.2017 um 02:28 schrieb Olof Johansson:
>>> On Thu, May 25, 2017 at 02:04:03PM +0200, Andreas F??rber wrote:
>>>> Hi Arnd and Olof,
>>>>
>>>> This is the initial arm64 pull for Realtek.
>>>>
>>>> Regards,
>>>> Andreas
>>>>
>>>> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
>>>>
>>>>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   git://github.com/afaerber/linux.git tags/realtek-arm64-soc-for-4.12
>>>
>>> This is v4.13 material at this point, so I've merged it into next/arm64 for
>>> the next merge window (v4.13). Thanks!
>>
>> Arnd had told me to rebase onto v4.12-rc1 (from v4.11-rc1) but to not
>> wait for the 4.13 merge window. Therefore I submitted it for 4.12.
>> Miscommunication? Either way works for me.
>
> To clarify: by "4.13 merge window", I meant the time when we send pull
> requests to Linus, i.e. the two weeks between the 4.12 release and
> 4.13-rc1.
>
> Since you want the pull request to be part of 4.13, you need to send it
> between 4.12-rc1 and 4.13 (ideally early during that time frame), and
> have it based on 4.12-rc1. The patches were based on 4.11-rc before,
> so I recommended rebasing to reduce the gap between the base
> and the merge commit.
>
> Does it make sense now?

And just to clarify: You did exactly what we want our platform
maintainers to do, Andreas -- the only disconnect seems to be that it
was 4.13 material instead of 4.12 by now.

I.e. timing for sending this is great -- please do it as early as you
can during -rc series, and try to get amount of submissions down to
mostly a trickle towards -rc6 and later, i.e. only smaller incremental
stuff with the bulk landing early.

If you can. :)

>
> > Now that you have merged ARCH_REALTEK here, should we update the arm64
> > defconfig to enable it? I just verified on arm-soc.git for-next that's
> > it's disabled by default; the only other disabled ones are ARCH_BRCMSTB
> > and to-be-dropped ARCH_VULCAN. Question is, should it be useful to users
> > before we do so, or is build-testing enough of a reason?
>
> I'd leave that up to you. Send a patch or pull request when you think it should
> be enabled. I'd tend to having it only enabled when it at least boots on some
> hardware, but we haven't had strong rules about that so far.


Agreed. We can enable now or later, no big deal.

Getting build coverage early doesn't hurt but if it doesn't really
boot anywhere there's not much other use in enabling.


-Olof
