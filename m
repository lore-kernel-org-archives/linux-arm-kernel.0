From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 12 Feb 2016 11:33:17 -0700
Subject: [PATCH V3 1/6] stm class: Add ioctl get_options interface
In-Reply-To: <87ziv62bzb.fsf@ashishki-desk.ger.corp.intel.com>
References: <1454756672-12790-1-git-send-email-zhang.chunyan@linaro.org>
 <1454756672-12790-2-git-send-email-zhang.chunyan@linaro.org>
 <87ziv62bzb.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkzQTjROVX3K3NEE=GNg6QVKXLA9QDLVDe+W9eeDVwbgGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 February 2016 at 08:18, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Chunyan Zhang <zhang.chunyan@linaro.org> writes:
>
>> There is already an interface of set_options, but no get_options yet.
>> Before setting any options, one would may want to see the current
>> status of that option by means of get_options interface. This
>> interface has been used in CoreSight STM driver.
>
> I'm not sure I understand the reasoning behind this. If a userspace
> program opens a communication channel and wants to configure certain
> features on it, why does its choice depend on what has been configured
> for this channel previously? It can be anything at all. Most likely,
> it's either unconfigured or configured to its default values, but why
> does this matter for a new writer?

A client may wish to change the settings (invariant/guaranteed) it has
on a specific channel - it may even want to so do multiple times.  The
idea behind introducing a get_options() was to probe the specific
settings of a channel before going a head with a new configuration.
In hindsight it may not be needed as a client should simply go ahead
and push down the configuration it wants.

>
> Regards,
> --
> Alex
