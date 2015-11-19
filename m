From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Nov 2015 14:32:16 +0100
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <mvm37w2p1kj.fsf@hawking.suse.de>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <3754277.KmO9Nk3XLD@wuerfel> <mvm37w2p1kj.fsf@hawking.suse.de>
Message-ID: <3771653.pOZ6XkUXAn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 November 2015 14:21:16 Andreas Schwab wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Wednesday 18 November 2015 00:16:54 Yury Norov wrote:
> >> +#define sys_lseek                      sys_llseek
> >
> > This seems pointless, as there is no sys_lseek
> 
> I think it should be the other way round.  Why would you want to use
> llseek if you can pass loff_t in a single register?

Right, it makes more sense the other way round.

	Arnd
