From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Mar 2018 11:51:45 +0100
Subject: [PATCH 2/2] ARM: npcm: drop extraneous 'select' statements
In-Reply-To: <CAKKbWA5F29HJFOTNfVmt14Qg5rMgrLSsHjY4NQESZL6OKmA95w@mail.gmail.com>
References: <20180307162430.2664523-1-arnd@arndb.de>
 <20180307162430.2664523-2-arnd@arndb.de>
 <CACPK8XeVMSeQNkPNp1_vms97H_9rMuk1-DzUAc=s-7o=FmVncw@mail.gmail.com>
 <CAKKbWA5F29HJFOTNfVmt14Qg5rMgrLSsHjY4NQESZL6OKmA95w@mail.gmail.com>
Message-ID: <CAK8P3a3fCRAuBjLXbjzc+1rYJsW90TDN2URZ=sOHvRNB3kyd6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 8, 2018 at 11:46 AM, Avi Fishman <avifishman70@gmail.com> wrote:
> So at least replace CACHE_L2X0 with MIGHT_HAVE_CACHE_L2X0 then
> CACHE_L2X0 will be selected by default and user can still remove it.

I looked at the other platforms for this one again, and found that most simply
select CONFIG_CACHE_L2X0 directly, so we probably want the same here
after all.

The ones that use MIGHT_HAVE_CACHE_L2X0 are the platforms
that have multiple SoCs in one family, and only some of them have an
L2X0. Is that the case here as well? Usually, the L2X0 is used with
Cortex-A9 and A5, rarely on older cores, and never on newer
ones.

       Arnd
