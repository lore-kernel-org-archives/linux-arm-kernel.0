From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 15 Dec 2014 10:06:51 -0800
Subject: [RFC PATCH 2/2] iommu: rockchip: Handle system-wide and runtime PM
In-Reply-To: <CAMuHMdVpCgK-hNqZ=JWjFGS53g+ZUQ5t=uBxtN1qGXJhoRg8BQ@mail.gmail.com>
 (Geert Uytterhoeven's message of "Mon, 15 Dec 2014 09:35:09 +0100")
References: <1418286387-9663-1-git-send-email-tfiga@chromium.org>
 <7h8uiemce7.fsf@deeprootsystems.com>
 <CAPDyKFo6zH4__Odm+RiJCbvXquAQqaLyCAiXrSN6s3KfQhok=A@mail.gmail.com>
 <1576771.dIVCOxU0se@vostro.rjw.lan>
 <CAAFQd5B28WiWUqmbmROJUa3H25R=Y774NuemTZDvkoa=CvZUsw@mail.gmail.com>
 <7ha92sk533.fsf@deeprootsystems.com>
 <CAMuHMdVpCgK-hNqZ=JWjFGS53g+ZUQ5t=uBxtN1qGXJhoRg8BQ@mail.gmail.com>
Message-ID: <7hr3w0iy84.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Fri, Dec 12, 2014 at 9:04 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> An even more exciting problem exists when a CPU is in the same domain as
>> other peripherals, those peripherals are all idle and the power domain
>> is gated. :)
>
> We do have pm_genpd_attach_cpuidle() and pm_genpd_name_attach_cpuidle()?

Exactly.  

And I think to solve this problem, we need to generalize the attaching
of dependent devices to a PM domain.

Kevin
