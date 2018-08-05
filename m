From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 5 Aug 2018 15:49:20 +0200
Subject: [RFC net-next 00/15] net: A socket API for LoRa
In-Reply-To: <BY1PR02MB11143134B9ABAC9C9929A9C4E7530@BY1PR02MB1114.namprd02.prod.outlook.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <BY1PR02MB11147C7443AB9623D6B65798E75A0@BY1PR02MB1114.namprd02.prod.outlook.com>
 <e08cdcfb-207f-bd73-2afd-f775810b72b7@suse.de>
 <BY1PR02MB11143134B9ABAC9C9929A9C4E7530@BY1PR02MB1114.namprd02.prod.outlook.com>
Message-ID: <b7d67853-2b22-e9c3-edb5-85f937d95c5c@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben and Jian-Hong,

[- SPI - devicetree]

Am 18.07.2018 um 13:28 schrieb Ben Whitten:
>> Meanwhile my attempt to play with netlink during SUSE
>> Hackweek has been
>> going slow and I could use some guidance or a volunteer to
>> contribute: I
>> have a bare skeleton of registration, commands, attributes
>> and multicast
>> groups, but no plan yet how to connect that to the actual
>> drivers to
>> query or apply the settings...
> 
> Happy to help, I will be starting from zero on netlink but I can contribute my existing work incorporating Marks comments for sx1301 etal.

I've figured out a way to retrieve a frequency value via netlink:
By passing the lora0 ifindex in as attribute, nllora can look up the
net_device by index, and then via struct lora_dev_priv call into hooks
that the device drivers can optionally implement. :)

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-lora.git/tree/net/lora/netlink.c?h=lora-next

Tested with HIMO-01M module.
The command might need an additional channel attribute for SX130x.

The corresponding nltest program (using libnl-genl) is here:
https://github.com/afaerber/lora-modules/blob/master/nltest.c

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
