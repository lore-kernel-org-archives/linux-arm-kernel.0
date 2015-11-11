From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Nov 2015 21:40:32 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <mvmsi4cxw07.fsf@hawking.suse.de>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <1446507046-24604-14-git-send-email-ynorov@caviumnetworks.com>
 <mvmsi4cxw07.fsf@hawking.suse.de>
Message-ID: <20577001.4Nl3YnQ8k2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 November 2015 18:54:00 Andreas Schwab wrote:
> Yury Norov <ynorov@caviumnetworks.com> writes:
> 
> > +#define sys_clock_gettime       compat_sys_clock_gettime
> > +#define sys_clock_settime       compat_sys_clock_settime
> 
> You also need to redirect sys_clock_nanosleep.

Note that based on my comment, that table would be turned around, and
only the syscalls get overridden that do not have the normal
compat mode behavior (mostly the ones that pass a 64-bit register).

	Arnd
