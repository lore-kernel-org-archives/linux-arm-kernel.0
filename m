From: mwjian@foxmail.com (=?utf-8?B?6ams5paH5YGl?=)
Date: Tue, 7 Aug 2018 09:59:13 +0800
Subject: [PATCH] ARM: spinlock: avoid exclusive accesses on unlock()
 path
In-Reply-To: <tencent_6BF9DD7B77B1CAA95FBAEE73@qq.com>
References: <tencent_76D135D5D379BDAB2A2436393315C6E4E807@qq.com>
 <tencent_6BF9DD7B77B1CAA95FBAEE73@qq.com>
Message-ID: <tencent_7ECB5CA838202151603A2FF6@qq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
while one cpu is doing arch_spin_unlock,another cpu doing arch_spin_lock
the first cpu's
lock->tickets.owner++;
may be over writed by the second's 
strex	%2, %1, [%3]\n
so the owner filed doesn't get increased. 

But i'm not sure about this, may be there are something i have missed. 

Thanks.

------------------ Original ------------------
