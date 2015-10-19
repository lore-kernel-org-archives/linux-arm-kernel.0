From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Oct 2015 23:55:32 +0200
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <20151019113904.GE10678@leverpostej>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <561FC681.2040809@arm.com>
 <CACRpkdaSox9WKb5-dkD_zAwO9WxP6+b010p3bdxsm1LRy=WvKg@mail.gmail.com>
 <5624C31D.3070906@arm.com> <20151019102932.GB10678@leverpostej>
 <CACRpkdaGscb_ccbGuwccsRj_b1d6xoveiiZpw1a5eXon3PxAUA@mail.gmail.com>
 <20151019113904.GE10678@leverpostej>
Message-ID: <CACRpkdb1XRSq3EERbiMwCnuV7Dtit2xGYRDBtQ9+odyXq6kM7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 1:39 PM, Mark Rutland <mark.rutland@arm.com> wrote:

> As I mentioned, I was under the impression that at least a portion of
> the flash was used by UEFI for variable storage, and that UEFI could
> therefore access the flash at runtime (due to runtime services calls).

OK I see. But doesn't that portion of the flash live inside one of the
AFS partitions simply?

If it is not then Juno has a mess of structured/unstructured flash
layout and it should be fixed by wrapping it into an AFS partition.

> Accessing the flash at the same time as another agent (UEFI or the
> Trusted Firmare) does not seem like a good idea, and is potentially
> unsafe (see Sudeep's example w.r.t. cpuidle).

No why would anyone do that. As with all file systems and
partitions it is possible to destroy them if you can access them,
with great power comes great responsibility as always, I'm just
not fond of the idea of hiding things behind the back for hackers
"for their own good", that is not the right spirit I think.

> Given that there is no mechanism to mediate access to the flash,
> allowing Linux to access it does not seem safe.

Linux does not access it, it just gives it a name and says
"there it is". Policy regarding accessing it is another issue
altogether. I also made the series with AFSv2 support.

Linus
