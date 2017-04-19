From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Apr 2017 21:56:39 +0200
Subject: [GIT PULL] ARM: SOC PM domain for 4.12
In-Reply-To: <1491500546-6873-1-git-send-email-ssantosh@kernel.org>
References: <1491500546-6873-1-git-send-email-ssantosh@kernel.org>
Message-ID: <CAK8P3a0jtLFgzB-u1Prhn1AvPH3OzLZ=uc--YP4fo9-7irikag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 6, 2017 at 7:42 PM, Santosh Shilimkar <ssantosh@kernel.org> wrote:
> Hi Arnd, Olof,
>
> As inidcated on the list, because of various dependencies, am senidng
> Dave Gerlach's full patchset in single pull request.
>
> The following changes since commit 4495c08e84729385774601b5146d51d9e5849f81:
>
>   Linux 4.11-rc2 (2017-03-12 14:47:08 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/arm-soc-pmdomain
>
> for you to fetch changes up to ae3874cc931b760c08bd6617a45fec1ba97d87f8:
>
>   ARM: keystone: Drop PM domain support for k2g (2017-04-04 08:59:28 -0700)
>
> ----------------------------------------------------------------
> ARM SOC PM domain support for 4.12
>
> Dave Gerlach (5):
>       PM / Domains: Add generic data pointer to genpd data struct
>       PM / Domains: Do not check if simple providers have phandle cells
>       dt-bindings: Add TI SCI PM Domains
>       soc: ti: Add ti_sci_pm_domains driver
>       ARM: keystone: Drop PM domain support for k2g

I went through the list of arm at kernel.org emails that had not seen a reply after
Olof's pull marathon today. I did not get a reply for this one, but I
see that Olof
has merged it into next/drivers.

Since I was looking at it, I also took a closer look at the contents of the
patch series. The driver itself looks fine, but for the record, I'm not that
happy about seeing a header file duplicating the information from the
data sheet: We only use dt-binding headers to establish an interface between
the driver and the sources when there is well-defined fixed way to enumerate
resources, but in this case there clearly is...

        Arnd
