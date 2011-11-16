From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 16 Nov 2011 13:59:40 -0800
Subject: [PATCH v6 3/5] ARM: soft_restart: disable the outer L2 when the
 last CPU is going down
In-Reply-To: <20111116183036.GR4942@mudshark.cambridge.arm.com>
References: <1321466057-19721-1-git-send-email-will.deacon@arm.com>
 <1321466057-19721-4-git-send-email-will.deacon@arm.com>
 <4EC3FED8.7000307@codeaurora.org>
 <20111116183036.GR4942@mudshark.cambridge.arm.com>
Message-ID: <4EC4324C.3000300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/11 10:30, Will Deacon wrote:
> Hi Stephen,
>
> On Wed, Nov 16, 2011 at 06:20:08PM +0000, Stephen Boyd wrote:
>> When does this code execute on another cpu? My understanding is that
>> soft_restart() is only called on one CPU so I would think checking the
>> number of online cpus isn't necessary.
> Currently, yes, this only executes on one CPU. The code is there in case
> we want to implement a SMP kexec solution that doesn't require CPU hotplug
> at some point.
>
> I suppose you could end up in a situation where the reset path leads to a
> soft reboot and you haven't dealt with the secondaries at this point, but
> then you have bigger problems to worry about (namely that whatever you jump
> to after turning the MMU off needs to deal with the secondaries somehow).

Fair enough. I was just curious.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
