From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 10 May 2017 11:55:21 -0700
Subject: [GIT PULL] TEE driver infrastructure and OP-TEE drivers
In-Reply-To: <CAK8P3a06+bG93H0XzAF1UUN_BbV-Cg3ERpVdR6qLuLpZUmp2Ug@mail.gmail.com>
References: <CAK8P3a06+bG93H0XzAF1UUN_BbV-Cg3ERpVdR6qLuLpZUmp2Ug@mail.gmail.com>
Message-ID: <CA+55aFxfBG5tc3ysXF_A_5mvsYk4Y2zdq+OD_oxoaDz0UrXMKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 9, 2017 at 12:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> TEE driver infrastructure and OP-TEE drivers

Another note: right now this adds a config question for TEE support,
but the only actual TEE driver has a

        depends on HAVE_ARM_SMCCC

on it.

Until we get more TEE drivers, might I suggest that we perhaps make
the TEE config option have

        depends on HAVE_ARM_SMCCC || COMPILE_TEST

so that the generic tee code still gets the compile test coverage, but
we don't confuse people by asking about infrastructure that they can't
possibly use..

Hmm?

                Linus
