From: davem@davemloft.net (David Miller)
Date: Wed, 02 Mar 2016 13:46:03 -0500 (EST)
Subject: [PATCH] batman-adv: clarify CFG80211 dependency
In-Reply-To: <20160302144607.GH7704@prodigo.lan>
References: <1456926882-2941809-1-git-send-email-arnd@arndb.de>
 <20160302144607.GH7704@prodigo.lan>
Message-ID: <20160302.134603.447218907358875583.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antonio Quartulli <a@unstable.cc>
Date: Wed, 2 Mar 2016 22:46:07 +0800

> On Wed, Mar 02, 2016 at 02:54:35PM +0100, Arnd Bergmann wrote:
>> The driver calls cfg80211_get_station, which may be part of a
>> module, so we must not enable BATMAN_ADV_BATMAN_V if
>> BATMAN_ADV=y and CFG80211=m:
>> 
>> net/built-in.o: In function `batadv_v_elp_get_throughput':
>> (text+0x5c62c): undefined reference to `cfg80211_get_station'
>> 
>> This clarifies the dependency to cover all combinations.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: c833484e5f38 ("batman-adv: ELP - compute the metric based on the estimated throughput")
> 
> Acked-by: Antonio Quartulli <a@unstable.cc>
> 
> Thanks a lot Arnd!
> 
> David, could you please merge this change in net-next directly ?

Done, applied, thanks everyone.
