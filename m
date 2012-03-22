From: viresh.linux@gmail.com (viresh kumar)
Date: Thu, 22 Mar 2012 06:11:19 +0530
Subject: [PATCH v3] serial: PL011: clear pending interrupts
In-Reply-To: <CACRpkdZ-epTV8dAY4gT9HKgPifRS_wfooy0QqEGsSgCqZ98MYw@mail.gmail.com>
References: <1331641643-25929-1-git-send-email-linus.walleij@stericsson.com>
 <CAOh2x=nh-aiJ1FQecm=5WsNw=Fph5osNh5C2YU6x9TGrKBoMmA@mail.gmail.com>
 <CACRpkdZ-epTV8dAY4gT9HKgPifRS_wfooy0QqEGsSgCqZ98MYw@mail.gmail.com>
Message-ID: <CAOh2x=mrjzX=BuoQW+pdcHsdzyenXFEbt0jNTYf-HV0GNk--1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2012 at 12:38 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> Strange, because these changes are not even in 3.3. Did you mean 3.4
> HEAD?

Ya. you are correct, actually i was switching between both of them and so
wrote 3.3 :(

> The uap->port is likely the problem. The clock does not need to be
> enabled for this, the clock that need to be enabled is the pclk and that
> should be taken care of by the amba/primecell core.

Ya. I know uap->port is the problem. But i thought like normal platform drivers
writers: "we need to enable clk too". And i was wrong :(.

> I'm sending a fixup patch to sort out my own screwing up.

Waiting for that.

--
viresh
