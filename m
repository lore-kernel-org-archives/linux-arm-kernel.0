From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Thu, 28 Jun 2018 08:17:59 +0200
Subject: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
In-Reply-To: <20180627171757.amucnh5znld45cpc@armageddon.cambridge.arm.com>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <0cef1643-a523-98e7-95e2-9ec595137642@arm.com>
 <20180627171757.amucnh5znld45cpc@armageddon.cambridge.arm.com>
Message-ID: <20180628061758.j6bytsaj5jk4aocg@ltop.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 06:17:58PM +0100, Catalin Marinas wrote:
> 
> sparse is indeed an option. The current implementation doesn't warn on
> an explicit cast from (void __user *) to (unsigned long) since that's a
> valid thing in the kernel. I couldn't figure out if there's any other
> __attribute__ that could be used to warn of such conversion.

Hi,

sparse doesn't have such attribute but would an new option that would warn
on such cast be a solution for your case?

-- Luc
