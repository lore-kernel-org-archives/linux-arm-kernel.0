From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 25 Nov 2013 11:45:01 -0800
Subject: [PATCH 11/31] dma: add channel request API that supports deferred
 probe
In-Reply-To: <5293A573.2050704@wwwdotorg.org>
References: <528D28A1.2050307@wwwdotorg.org>
 <CAPcyv4jRYu7iTOuiXuj9F-t5dpF3ErVHT4X-PKrkJAYfn91a0w@mail.gmail.com>
 <528E4F55.9070204@wwwdotorg.org>
 <CAPcyv4jTUVjhFFXP8RL2jCqFj1MqxSCKQYvfdLHTj+1PRDDL3Q@mail.gmail.com>
 <528F95A9.2050305@wwwdotorg.org>
 <CAPcyv4iXmBmcsHDc7yjxxbH7sO8m1nVoEO6PUibuDeb1Wtge+g@mail.gmail.com>
 <528F9DF9.6080706@wwwdotorg.org>
 <20131123003442.GH16735@n2100.arm.linux.org.uk>
 <5293883A.8050808@wwwdotorg.org>
 <CAA9_cmfMtp4WjRGVzfTxrwcNWP95+HE7DAYg_GeWfqi=L2K2aw@mail.gmail.com>
 <20131125180000.GR16735@n2100.arm.linux.org.uk>
 <CAA9_cmcqO-=7Gf53ygG3oYwC0=fQgF8xPL2Wywgw84Dz1ZKs6g@mail.gmail.com>
 <52939E67.6040300@wwwdotorg.org>
 <CAPcyv4hPy_zddiideTk9HNOZnKzkGqKeT4m6wDyckDmbkoMacA@mail.gmail.com>
 <5293A573.2050704@wwwdotorg.org>
Message-ID: <CAPcyv4ijv2=Fnp9mVKoAUGL9DLYh=6ZSsUd_PWxZqxQ7yZ61hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 11:30 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/25/2013 12:28 PM, Dan Williams wrote:
>> On Mon, Nov 25, 2013 at 11:00 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> I suppose an alternative would be to remove that flag, and have the loop
>>> in of_dma_request_slave_channel() initially ignore any unregistered DMA
>>> controllers, and still continue to look through the property for any
>>> alternative controller, and return a channel from one if it is found.
>>> Then, at the very end of the function, we could always return
>>> -EPROBE_DEFER if any unregistered DMA controllers were found, otherwise
>>> return -ENODEV. That would keep compatible behaviour, but it would mean
>>> that device probe order would/could influence which dmas entry provided
>>> the channel, since some entries might be ignored based simply on
>>> timing/ordering of DMA controller registration. Is that acceptable?
>>>
>>
>> Yes, I think this option makes the most sense, and is just as
>> susceptible to probe order as the current implementation.
>
> OK great. Last two questions then:
>
> 1) Do you want me to revert the changes to acpi-dma.c, and simply handle
> the return value conversion inside __dma_request_slave_channel().

Yeah, no need to spread the complexity further than necessary.

> 2) What's the final call on the new API name?

What do you think of _reason?  I just read the existence of
dma_request_slave_channel_or_err() as an implication that
dma_request_slave_channel() may not fail.

> Just let me know on both - the changes are simple. Thanks.

Well thanks for hashing this back and forth, we can laugh about it
over a drink at the next conference.
