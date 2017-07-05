From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 5 Jul 2017 14:31:38 +0200
Subject: [GIT PULL 5/7] ARM: SoC driver updates
In-Reply-To: <CA+55aFyn0QFR3DYYaP2tOgxwYPzRgHfCmJ2fVXinZKsx_F8fBQ@mail.gmail.com>
References: <CAK8P3a0Pizf3ZBjG7Sn2BB_g+wtewz-CtJnOU5voONGvWS=EGA@mail.gmail.com>
 <CA+55aFyn0QFR3DYYaP2tOgxwYPzRgHfCmJ2fVXinZKsx_F8fBQ@mail.gmail.com>
Message-ID: <CAK8P3a0FhDgP8foc2EEmgA3g69SSXgPaZmt3bCW538gWKwWrBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 4, 2017 at 11:53 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jul 4, 2017 at 7:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>  create mode 100644 drivers/soc/actions/Kconfig
>>  create mode 100644 drivers/soc/actions/Makefile
>>  create mode 100644 drivers/soc/actions/owl-sps-helper.c
>>  create mode 100644 drivers/soc/actions/owl-sps.c
>
> You already had these in the platform updates.

Yes, that was intentional. We had not originally decided which branch to send
first, so I asked Andreas to include the same commits in both branches.

The SMP support in arch/arm/mach-actions has a build-time dependency
on the code, so it needed to be in there, and the drivers branch simply
includes all the drivers/*/ changes.

In the past I sometimes generated the log in the pull request to match what
you are expected to see in the real merge, instead of the diff against mainline,
but now I only do that in case we have to do a backmerge for some reason
(most of the time we can avoid those, I think this time one of the pull requests
had a backmerge of 4.12-rc1..4.12-rc2).

Let me know if you would rather have us handle this differently.

      Arnd
