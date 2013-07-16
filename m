From: gorcunov@gmail.com (Cyrill Gorcunov)
Date: Tue, 16 Jul 2013 13:53:49 +0400
Subject: [PATCH] arm: align shared memory unconditionally to the SHMLBA
 boundary
In-Reply-To: <51E4DC0B.8040908@parallels.com>
References: <1361254269-3444-1-git-send-email-alekskartashov@parallels.com>
 <20130715173238.GJ1730@moon>
 <20130715180846.GV24642@n2100.arm.linux.org.uk>
 <20130715185739.GK1730@moon> <51E4DC0B.8040908@parallels.com>
Message-ID: <20130716095349.GB16370@moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 09:37:15AM +0400, Alexander Kartashov wrote:
> On 07/15/2013 10:57 PM, Cyrill Gorcunov wrote:
> >Alexander, mind to remind where exactly we're failing in c/r procedure
> 
> It isn't always possible to pin an IPC SHM region
> using shmat() at the address returned by shmget()
> so sometimes it's impossible to restore a process
> that uses the IPC SHM.

Does it mean that we simply can't checkpoint and restore on same
node (ie same arm family) if this patch is not applied, right?
Is there any possibility to somehow workaround this problem
completely in user-space?
