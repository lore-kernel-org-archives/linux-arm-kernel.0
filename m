From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Oct 2011 11:26:59 -0700
Subject: [PATCH] [3.3] ARM: tegra: emc: max rate based on emc table
In-Reply-To: <CAMbhsRSgLvvPMd69z7aa8A=9ndYuUkmhmsEzK4WFd3AsQBohzg@mail.gmail.com>
References: <1318961694-21105-1-git-send-email-olof@lixom.net>
	<CAMbhsRSgLvvPMd69z7aa8A=9ndYuUkmhmsEzK4WFd3AsQBohzg@mail.gmail.com>
Message-ID: <CAOesGMgD_q=opmUDVbuq-8HYfwXJkSdF5QUSngb-Vx5SSbR7ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 11:23 AM, Colin Cross <ccross@android.com> wrote:
> On Tue, Oct 18, 2011 at 11:14 AM, Olof Johansson <olof@lixom.net> wrote:
>> +
>> + ? ? ? c->max_rate = max * 2 * 1000;
> I don't think you should be modifying internal variables of the struct
> clk from here.

I was contemplating adding a clk_set_max_rate(). Looks like some
platforms already have it, so I'll just go ahead and do it.

I'll move the shared bus iteration to that code as well then, obviously.

>
>> +
>> + ? ? ? list_for_each_entry(user, &c->shared_bus_list, u.shared_bus_user.node)
>> + ? ? ? ? ? ? ? user->max_rate = c->max_rate;
