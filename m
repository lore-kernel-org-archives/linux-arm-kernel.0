From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 11 Apr 2013 20:07:16 +0200
Subject: [PATCH] net: mv643xx_eth: Add GRO support
In-Reply-To: <1365702955.7355.5.camel@bwh-desktop.uk.solarflarecom.com>
References: <1365684023-9967-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1365702955.7355.5.camel@bwh-desktop.uk.solarflarecom.com>
Message-ID: <5166FBD4.5020508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2013 07:55 PM, Ben Hutchings wrote:
> On Thu, 2013-04-11 at 14:40 +0200, Sebastian Hesselbarth wrote:
>> This patch adds GRO support to mv643xx_eth by making it invoke
>> napi_gro_receive instead of netif_receive_skb.
>
> The inet_lro support should be removed at the same time; inet_lro is now
> deprecated and there should be no need to keep both of them.

Ben,

I agree on removing it asap, but I also like to see GRO support
in. Maybe, we postpone lro removal just a little bit. I have just
started to look at mv643xx_eth and remember Marvell Orion SoCs are
not the only platform using it. I haven't heard a single word from
ppc guys, yet.

Willy just posted an experimental patch to remove lro. I'll have
a look at it and test it out on Dove.

Sebastian
