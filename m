From: alekskartashov@parallels.com (Alexander Kartashov)
Date: Tue, 16 Jul 2013 14:22:41 +0400
Subject: [PATCH] arm: align shared memory unconditionally to the SHMLBA
 boundary
In-Reply-To: <20130716095349.GB16370@moon>
References: <1361254269-3444-1-git-send-email-alekskartashov@parallels.com>
 <20130715173238.GJ1730@moon> <20130715180846.GV24642@n2100.arm.linux.org.uk>
 <20130715185739.GK1730@moon> <51E4DC0B.8040908@parallels.com>
 <20130716095349.GB16370@moon>
Message-ID: <51E51EF1.3010104@parallels.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2013 01:53 PM, Cyrill Gorcunov wrote:
> Does it mean that we simply can't checkpoint and restore on same
> node (ie same arm family) if this patch is not applied, right?
Yes, it does.
> Is there any possibility to somehow workaround this problem
> completely in user-space?
No, it's impossible since an IPC SHM region is allocated
by the routine shmget() in the dumpee; if the routine
returns an incorrectly aligned address it's impossible
to reattach the region at this address while restoring
the dumpee.

-- 
Sincerely yours,
Alexander Kartashov

Intern
Core team

www.parallels.com

Skype: aleksandr.kartashov
Email: alekskartashov at parallels.com
