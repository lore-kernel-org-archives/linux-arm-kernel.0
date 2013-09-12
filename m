From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Sep 2013 13:32:28 +0100
Subject: [PATCH 01/38] ARM: ux500: Remove PrimeCell IDs from Nomadik
 I2C DT nodes
In-Reply-To: <CACRpkdY-N_VJwdo4+y9-9==+iC_w4qSiiE2oY-hp_jgsJyxQbg@mail.gmail.com>
References: <CAOesGMgySNLKo_H0h4MCbAWvyW0h2bWa96drWBpnhAYYQwH9mw@mail.gmail.com>
 <20130910153037.GA11227@lee--X1>
 <CAOesGMiBN5SaEY26SxGaw9E4ViR3cC0PcwNMEd4cLJZMfomprQ@mail.gmail.com>
 <CACRpkdY24uU=tXirJqrxLH-45ORFGybJOg-2tDOkpSmFUQUiiw@mail.gmail.com>
 <20130911081911.GI11227@lee--X1>
 <CACRpkdY6v+LMggLBdfKc3VUPmRZXTf1zBi4a93EPhQeo21wMeQ@mail.gmail.com>
 <CAF2Aj3iPdqM-+FQ7R9MZ-6jV1Q1me9TG1P4cEGA7fSBBYH92zA@mail.gmail.com>
 <CACRpkdYfeao6bvwjq7YJhBNCoC_JVxPTwYzPPiWM0tgUQreJKg@mail.gmail.com>
 <CAOesGMi7zbGuBBaUToe7=PUJvUUT8FkdMAWzfCE0igpYiYTZSg@mail.gmail.com>
 <CACRpkdY-N_VJwdo4+y9-9==+iC_w4qSiiE2oY-hp_jgsJyxQbg@mail.gmail.com>
Message-ID: <20130912123228.GJ12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 02:23:48PM +0200, Linus Walleij wrote:
> Yeah somewhere the bit-banging from the LL-prints that just
> hammer the hardware start conflicting with the kernel control
> over the same port. I guess it's the same for all users of the
> PL011.

That shouldn't happen, unless the port becomes disabled (eg, you're
not using the LL-debug port as your console, and its then placed into
a low power mode.)

Again, let me re-interate what LL-debug is for: it's there to assist
getting the early boot up and running.  Once the early boot is working,
it should *not* be used.
