From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Mar 2018 15:59:34 +0200
Subject: [GIT PULL] firmware: ARM SCMI fixes for v4.17
In-Reply-To: <20180320183747.GB16362@e107155-lin>
References: <20180320183747.GB16362@e107155-lin>
Message-ID: <CAK8P3a2rJwaYG613RL=8oE9H8KUX9c6VQfOEcW2kJm=gZr7e3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2018 at 7:37 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi ARM SoC Team,
>
> I have based this on the earlier/first SCMI pull request I sent for
> v4.17. Couple of build/static checker warnings were reported and also
> received a comment from clock maintainer to use new devm_* API. This
> PR contains patches addressing those.

Pulled into next/drivers.

Anders, I noticed one small issue with your "firmware: arm_scmi:
prevent accessing
rate_discrete uninitialized" patch, this has both the initialization
and the change to
use a 'goto', but only the second change is actually required, while
the first one
makes the code slightly less reliable. It's still correct though, so
I'm not asking
for a respin here.

       Arnd
