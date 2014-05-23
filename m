From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 May 2014 15:46:09 +0200
Subject: [Ksummit-discuss] [TECH TOPIC] ARM legacy board DT conversion
 finalization
In-Reply-To: <CAL_Jsq+kOu82okhJn0_ftwemE_m4nsTRawrF-fWAU2XTJ9xRcA@mail.gmail.com>
References: <20140511030009.GO12708@titan.lakedaemon.net>
 <20140516184205.GL27822@titan.lakedaemon.net>
 <1400278842.2647.62.camel@deadeye.wl.decadent.org.uk>
 <4931877.zNfKfvcgox@wuerfel>
 <CAL_Jsq+kOu82okhJn0_ftwemE_m4nsTRawrF-fWAU2XTJ9xRcA@mail.gmail.com>
Message-ID: <CACRpkdaPStOjWeH9SgHKjcyrOfebbnvs_p5rWueNBdt9oBBMzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 1:06 AM, Rob Herring <robh@kernel.org> wrote:
> On Mon, May 19, 2014 at 7:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:

>> We should really have this in multiplatform soon, I think the last issue
>> for versatile is common clock support, but Linus Walleij may have more
>> details about what remains here.
>
> While not necessarily the same thing, but does move versatile in the
> right direction, I've got patches in progress which fully move
> versatile over to DT.

Doing this two-stage rocket:
Legacy -> DT -> multiplatform

Is usually the smoothest. That is what I did on U300, U8500
and will do on the Integrator.

> I'd like to do this all in one step to avoid doing things like non-DT
> common clock init. It's blocked on the common DT PCI code and my free
> time.

I agree. And invariably this will confuse a lot of QEMU users
until they figure out how to boot their new image with a device
tree. But that is business as usual I guess.

> There are then a few bits related to mach/plat headers needed move
> versatile to multiplatform. I think these issues are mostly the same
> changes that have been done or are needed on integrator which is what
> Linus has been working on.

I'm onto these as part of both Integrator and RealView modernization.

Yours,
Linus Walleij
