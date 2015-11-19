From: schwab@suse.de (Andreas Schwab)
Date: Thu, 19 Nov 2015 14:21:16 +0100
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <3754277.KmO9Nk3XLD@wuerfel> (Arnd Bergmann's message of "Tue, 17
 Nov 2015 22:57:52 +0100")
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-15-git-send-email-ynorov@caviumnetworks.com>
 <3754277.KmO9Nk3XLD@wuerfel>
Message-ID: <mvm37w2p1kj.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday 18 November 2015 00:16:54 Yury Norov wrote:
>> +#define sys_lseek                      sys_llseek
>
> This seems pointless, as there is no sys_lseek

I think it should be the other way round.  Why would you want to use
llseek if you can pass loff_t in a single register?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
