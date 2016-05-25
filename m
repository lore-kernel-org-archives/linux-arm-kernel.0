From: davem@davemloft.net (David Miller)
Date: Wed, 25 May 2016 13:50:39 -0700 (PDT)
Subject: [PATCH 01/23] all: syscall wrappers: add documentation
In-Reply-To: <6293194.tGy03QJ9ME@wuerfel>
References: <20160525200327.GA22395@yury-N73SV>
 <20160525.132145.1271448744307448631.davem@davemloft.net>
 <6293194.tGy03QJ9ME@wuerfel>
Message-ID: <20160525.135039.244098606649448826.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 25 May 2016 22:47:33 +0200

> If we use the normal calling conventions, we could remove these overrides
> along with the respective special-case handling in glibc. None of them
> look particularly performance-sensitive, but I could be wrong there.

You could set the lowest bit in the system call entry pointer to indicate
the upper-half clears should be elided.
