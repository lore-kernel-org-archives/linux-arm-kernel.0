From: cernekee@gmail.com (Kevin Cernekee)
Date: Mon, 25 Apr 2011 17:18:37 -0700
Subject: console_cpu_notify can cause scheduling BUG during CPU hotplug
In-Reply-To: <4DB604C7.8090305@codeaurora.org>
References: <4DB604C7.8090305@codeaurora.org>
Message-ID: <BANLkTimPHaiiiVC_A6jtUtaa_pYJuhepYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2011 at 4:33 PM, Michael Bohan <mbohan@codeaurora.org> wrote:
> I was curious if this scenario was accounted for in the design of the
> console CPU notifier. One workaround for this problem is to remove CPU_DEAD
> from the possible actions in console_cpu_notify(). In fact, v1-v4 of the
> patch above did not have CPU_DEAD, CPU_DYING or CPU_DOWN_FAILED in the list
> of actions. I wasn't able to track down why the other cases were added in
> the final patch.

Here is the background information on the CPU_{DEAD,DYING,DOWN_FAILED} cases:

http://lkml.org/lkml/2010/6/29/65
