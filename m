From: alekskartashov@parallels.com (Alexander Kartashov)
Date: Tue, 16 Jul 2013 09:37:15 +0400
Subject: [PATCH] arm: align shared memory unconditionally to the SHMLBA
 boundary
In-Reply-To: <20130715185739.GK1730@moon>
References: <1361254269-3444-1-git-send-email-alekskartashov@parallels.com>
 <20130715173238.GJ1730@moon> <20130715180846.GV24642@n2100.arm.linux.org.uk>
 <20130715185739.GK1730@moon>
Message-ID: <51E4DC0B.8040908@parallels.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2013 10:57 PM, Cyrill Gorcunov wrote:
> Alexander, mind to remind
> where exactly we're failing in c/r procedure

It isn't always possible to pin an IPC SHM region
using shmat() at the address returned by shmget()
so sometimes it's impossible to restore a process
that uses the IPC SHM.

-- 
Sincerely yours,
Alexander Kartashov

Intern
Core team

www.parallels.com

Skype: aleksandr.kartashov
Email: alekskartashov at parallels.com
