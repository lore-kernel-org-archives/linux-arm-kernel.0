From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 12 Feb 2016 17:18:48 +0200
Subject: [PATCH V3 1/6] stm class: Add ioctl get_options interface
In-Reply-To: <1454756672-12790-2-git-send-email-zhang.chunyan@linaro.org>
References: <1454756672-12790-1-git-send-email-zhang.chunyan@linaro.org>
 <1454756672-12790-2-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <87ziv62bzb.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chunyan Zhang <zhang.chunyan@linaro.org> writes:

> There is already an interface of set_options, but no get_options yet.
> Before setting any options, one would may want to see the current
> status of that option by means of get_options interface. This
> interface has been used in CoreSight STM driver.

I'm not sure I understand the reasoning behind this. If a userspace
program opens a communication channel and wants to configure certain
features on it, why does its choice depend on what has been configured
for this channel previously? It can be anything at all. Most likely,
it's either unconfigured or configured to its default values, but why
does this matter for a new writer?

Regards,
--
Alex
